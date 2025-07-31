//
//  HomeView.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftUI

struct FlashCard: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let meaning: String
}

struct HomeView: View {

    @State private var progress: Double = 0.5
    @State private var selectedCard: FlashCard?
    @State private var presentAddCard: Bool = false
    
    private static let items: [FlashCard] = [
        .init(title: "Abandon", meaning: "leave somewhere or someone without comeback"),
        .init(title: "Apple", meaning: "A friut with red skin")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBarView()
            xpTrackerView()
            
            wordCardView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $presentAddCard) {
            AddCardView()
        }
    }
    
    @ViewBuilder
    private func navigationBarView() -> some View {
        HStack {
            Text("Sib Learn")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                presentAddCard.toggle()
            } label: {
                Image(systemName: "plus")
                    .tint(Color.white)
                    .fontWeight(.bold)
                    .padding()
                    .background {
                        Circle()
                            .fill(Color.black)
                    }
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
    
    @ViewBuilder
    private func xpTrackerView() -> some View {
        HStack {
            CircularProgressView(progress: $progress)
            VStack {
                Text("Memorized today:")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("1 words of \(Self.items.count)")
                    .font(.system(size: 32, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .padding([.bottom, .horizontal], 32)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(
            RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
        )
    }
    
    @ViewBuilder
    private func wordCardView() -> some View {
        VStack(spacing: 0) {
            
            Text("Vocabulary")
                .foregroundStyle(Color.white)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.bottom, 8)

            
            ScrollView(.vertical) {
                VStack {
                    
                    ForEach(Self.items) { card in
                        cardView(card)
                    }
                    
                }
            }
        }
        .padding([.horizontal, .top])
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
            Color("DP")
                .clipShape(RoundedRectangle(cornerRadius: 12))
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
    private func cardFrontView(_ card: FlashCard) -> some View {
        Text(card.title)
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

#Preview {
    HomeView()
}
