//
//  FlashCardFeature.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import Combine
import ComposableArchitecture

@Reducer
struct FlashCardFeature {
    
    private let thread = DispatchQueue(label: "com.SibLearn.FlashCardFeatureThread")
    
    @Dependency(\.flashCardProvider) var flashCardProvider
    @Dependency(\.xpTrackerProvider) var xpTrackerProvider
    
    @ObservableState
    struct State: Equatable {
        var flashCards: [FlashCard] = []
        var userInput: String = ""
        var feedback: Bool? = nil
        var totalXP: Int = 0
        var isAddSheetPresented: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case startListenToFlashCardPublisher
        case fetchFlashCards
        case getTotalXp
        case flashCardsReceived([FlashCard])
        case receiveTotalXp(Int)
        case updateFlashCard(FlashCard)
        case checkAnswer(FlashCard, String)
        case toggleSheet(Bool)
    }
    
    enum CancelID {
        static let flashCardSubscription = "flashCardSubscription"
    }
    
}


//MARK: Reducer
extension FlashCardFeature {
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            case .binding(_):
                return .none
            case .startListenToFlashCardPublisher:
                return performStartListenToFlashCardPublisher()
            case .fetchFlashCards:
                return performFetchFlashCards()
            case .getTotalXp:
                return performGetTotalXp()
            case .flashCardsReceived(let flashCards):
                state.flashCards.insert(contentsOf: flashCards, at: 0)
                return .none
            case .receiveTotalXp(let totalXp):
                state.totalXP = totalXp
                return .none
            case .updateFlashCard(let flashCard):
                let flashCards = state.flashCards.map {
                    if $0.id == flashCard.id {
                        return flashCard
                    }
                    return $0
                }
                state.flashCards = flashCards
                return .none
            case .checkAnswer(let flashCard, let answer):
                return performCheckAnswer(state, flashCard: flashCard, answer: answer)
            case .toggleSheet(let isPresent):
                state.isAddSheetPresented = isPresent
                return .none
        }
    }
    
}

//MARK: Effects
extension FlashCardFeature {
    
    private func performStartListenToFlashCardPublisher() -> Effect<Action> {
        return .run { [provider = flashCardProvider] send in
            let cancellable = await provider.getFlashCardPublisher()
                .subscribe(on: thread)
                .receive(on: DispatchQueue.main)
                .sink { flashCard in
                    Task { @MainActor in
                        send(.flashCardsReceived([flashCard]))
                    }
                }

            await withTaskCancellation(id: CancelID.flashCardSubscription) {
                try? await Task.never()
            }

            _ = cancellable
        }
        .cancellable(id: CancelID.flashCardSubscription, cancelInFlight: true)
    }
    
    private func performFetchFlashCards() -> Effect<Action> {
        
        return .run { [provider = flashCardProvider] send in
            do {
                let flashCards = try await provider.getFlashCards()
                await send(.flashCardsReceived(flashCards))
            }
            catch {
                print("FlashCardFeature: Fetch flashcards is failed: \(error)")
            }
        }
    }
    
    private func performGetTotalXp() -> Effect<Action> {
        return .run { [xpProvider = xpTrackerProvider] send in
            do {
                let totalXp = try await xpProvider.getTotalXp()
                await send(.receiveTotalXp(totalXp))
            }
            catch {
                print("FlashCardFeature: Get total XP is failed: \(error)")
            }
        }
    }
    
    private func performCheckAnswer(_ state: State, flashCard: FlashCard, answer: String) -> Effect<Action> {
        return .run { send in
            do {
                let isCorrect = flashCard.meaning == answer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                let newFlashCard = flashCard.copy(isCorrect: isCorrect)
                try await flashCardProvider.updateFlashCard(flashCard: newFlashCard)
                if isCorrect {
                    let xp = state.totalXP + 10
                    try await xpTrackerProvider.updateTotalXp(xp)
                    await send(.getTotalXp)
                }
                await send(.updateFlashCard(newFlashCard))
            }
            catch {
                print("FlashCardFeature: Check answer is failed: \(error)")
            }
        }
    }
    
}
