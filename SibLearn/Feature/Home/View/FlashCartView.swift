//
//  FlashCartView.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftUI

struct FlashCartView: View {
    
    @Binding
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBarView()
            xpTrackerView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.ignoresSafeArea())
    }
    
    @ViewBuilder
    private func navigationBarView() -> some View {
        HStack {
            Text("Sib Learn")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
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
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
    
    @ViewBuilder
    private func xpTrackerView() -> some View {
        HStack {
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

#Preview {
    FlashCartView()
}
