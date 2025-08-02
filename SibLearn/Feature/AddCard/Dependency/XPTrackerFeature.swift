//
//  XPTrackerFeature.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct  XPTrackerFeature {
    
    @ObservableState
    struct State: Equatable {
        var isAddingFlashCard: Bool = false
        var wordValue = ""
        var meaningValue = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case addFlashCard(word: String, meaning: String)
        case dismissView
        case setWordValue(String)
        case setMeaningValue(String)
    }
    
    @Dependency(\.flashCardProvider) var flashCardProvider
}

//MARK: Reducer
extension XPTrackerFeature {
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            case .binding(_):
                return .none
            case .addFlashCard(word: let word, meaning: let meaning):
                return performAddFlashCard(word: word, meaning: meaning)
            case .dismissView:
                state.isAddingFlashCard = true
                return .none
            case .setWordValue(let value):
                state.wordValue = value
                return .none
            case .setMeaningValue(let value):
                state.meaningValue = value
                return .none
        }
    }
}

//MARK: Private Functions
extension XPTrackerFeature {
    
    private func performAddFlashCard(word: String, meaning: String) -> Effect<Action> {
        return .run { [provider = flashCardProvider] send in
            do {
                try await provider.addFlashCard(flashCard: FlashCard(id: UUID().uuidString, word: word, meaning: meaning, isCorrect: false, createdAt: Int(Date().timeIntervalSince1970)))
                await send(.dismissView)
            }
            catch {
                print("XPTrackerFeature: Add flashcard is failed: \(error)")
            }
        }
    }
    
}
