//
//  XpTrackerView.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//

import SwiftUI

struct XpTrackerView: View {
    
    var totalFlashCards: Int
    var totalXP: Int
    var flashCards: [FlashCard]
    
    var body: some View {
        HStack {
            
            let progress: Double = flashCards.isEmpty ? 0 : Double(getCorrectAnswersCount()) / Double(totalFlashCards)
            CircularProgressView(progress: progress, totalXP: totalXP)
            VStack {
                Text("Memorized today:")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("\(getCorrectAnswersCount()) words of \(totalFlashCards)")
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
    
    private func getCorrectAnswersCount() -> Int {
        return flashCards.lazy.filter({ ($0.isCorrect ?? false) }).count
    }
}

#Preview {
    XpTrackerView(totalFlashCards: 10, totalXP: 10, flashCards: [])
}
