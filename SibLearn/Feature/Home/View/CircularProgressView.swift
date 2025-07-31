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
    private let size: CGFloat = 80

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("LP"), lineWidth: lineWidth)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color("DP"),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // Start from top
                .animation(.easeOut(duration: 0.5), value: progress)

            VStack(spacing: -4) {
                Text("50")
                    .font(.system(size: 24, weight: .bold))
                Text("xp")
                    .font(.system(size: 12, weight: .light))
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    HomeView()
}
