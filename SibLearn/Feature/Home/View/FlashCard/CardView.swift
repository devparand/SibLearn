//
//  CardView.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//
import SwiftUI

struct CardView: View {
    
    @State private var selectedCard: FlashCard?
    @State private var answerValue = ""
    
    var card: FlashCard
    var onSubmit: (FlashCard, String) -> Void
    
    var body: some View {
        VStack {
            cardView(card)
            answerView(card)
            Divider()
                .background(Color.white)
                .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    private func cardView(_ card: FlashCard) -> some View {
        let angle = (card == selectedCard) ? 180.0 : 0.0
        ZStack {
            if card == selectedCard {
                cardBackView(card)
            }
            else {
                cardFrontView(card)
            }
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 150)
        .background {
            ZStack {
                Color("DP")
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                RoundedRectangle(cornerRadius: 12)
                    .stroke(card.isCorrect == nil ? Color.clear : ((card.isCorrect ?? false) ? Color.green : Color.red), lineWidth: card.isCorrect == nil ? 0 : 5)
            }
        }
        .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            withAnimation(.spring()) {
                if selectedCard == card {
                    selectedCard = nil
                }
                else {
                    selectedCard = card
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func answerView(_ card: FlashCard) -> some View {
        HStack {
            Text("Meaning: ")
                .foregroundStyle(.black)
                .font(.system(size: 16, weight: .medium))
            
            TextField("Meaning", text: $answerValue)
                .foregroundStyle(.DP)
                .font(.system(size: 16, weight: .medium))
                .onSubmit {
                    guard !answerValue.isEmpty else {return}
                    onSubmit(card, answerValue)
                    
                }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
    }
    
    @ViewBuilder
    private func cardFrontView(_ card: FlashCard) -> some View {
        Text(card.word)
            .foregroundStyle(card.isCorrect == nil ? Color.white : ((card.isCorrect ?? false) ? Color.green : Color.red))
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    private func cardBackView(_ card: FlashCard) -> some View {
        Text(card.meaning)
            .font(.title2)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}
