//
//  HomeNavigationBarView.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//

import SwiftUI

struct HomeNavigationBarView: View {
    
    var onAddCardTapped: (() -> Void)
    
    var body: some View {
        HStack {
            Text("Sib Learn")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                onAddCardTapped()
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
}

#Preview {
    HomeNavigationBarView(onAddCardTapped: {})
}
