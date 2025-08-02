//
//  FlashCardView.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//

import SwiftUI
import ComposableArchitecture

struct FlashCardView: View {
    
    var flashCards: [FlashCard]
    var onSubmit: (FlashCard, String) -> Void
    
    var body: some View {

        VStack(spacing: 0) {
            
            Text("Vocabulary")
                .foregroundStyle(Color.white)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.bottom, 8)

            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    ForEach(flashCards) { card in
                        CardView(card: card) { currentCard, answer in
                            onSubmit(currentCard, answer)
                        }
                    }
                    
                }
            }
        }
        .padding([.horizontal, .top])
    }
    
}

#Preview {
    HomeView(
        store: Store(initialState: FlashCardFeature.State()) {
            FlashCardFeature()
        }
    )
}
