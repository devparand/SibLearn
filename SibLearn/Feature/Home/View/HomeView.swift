//
//  HomeView.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    
    private let store: StoreOf<FlashCardFeature>
    @State private var isInit: Bool = false
    
    init(store: StoreOf<FlashCardFeature>) {
        self.store = store
    }
    
    var body: some View {
        
        WithViewStore(store, observe: \.self) { viewStore in
            
            VStack(spacing: 0) {
                
                HomeNavigationBarView {
                    viewStore.send(.toggleSheet(true))
                }
                
                XpTrackerView(totalFlashCards: viewStore.flashCards.count, totalXP: viewStore.state.totalXP, flashCards: viewStore.flashCards)
                
                if viewStore.flashCards.isEmpty {
                    emptyFlashCardView()
                }
                else {
                    FlashCardView(flashCards: viewStore.flashCards) { (card, answer) in
                        viewStore.send(.checkAnswer(card, answer))
                    }
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.black.ignoresSafeArea())
            .sheet(isPresented: viewStore.binding(get: { state in
                state.isAddSheetPresented
            }, send: { value in
                    .toggleSheet(value)
            })) {
                AddCardView(
                    store: Store(initialState: XPTrackerFeature.State()) {
                        XPTrackerFeature()
                    }
                )
            }
            .onAppear {
                guard !isInit else {return}
                self.isInit = false
                viewStore.send(.startListenToFlashCardPublisher)
                viewStore.send(.fetchFlashCards)
                viewStore.send(.getTotalXp)
            }
        }
    }
    
    @ViewBuilder
    private func emptyFlashCardView() -> some View {
        Text("No cards yet.")
            .foregroundStyle(Color.white)
            .font(.system(size: 20, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView(
        store: Store(initialState: FlashCardFeature.State()) {
            FlashCardFeature()
        }
    )
}
