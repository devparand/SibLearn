//
//  CircularProgressView.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding var progress: Double
    private let lineWidth: CGFloat = 10
    private let size: CGFloat = 100

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)

            // Progress circle
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // Start from top
                .animation(.easeOut(duration: 0.5), value: progress)

            // Optional: Show progress text
            Text("\(Int(progress * 100))%")
                .font(.system(size: 18, weight: .bold))
        }
        .frame(width: size, height: size)
    }
}
