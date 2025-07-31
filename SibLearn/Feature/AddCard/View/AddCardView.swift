//
//  AddCardView.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftUI

struct AddCardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var wordValue: String = ""
    @State private var meaningValue: String = ""
    var onAddCardTapped: (() -> Void)?
    
    var body: some View {
        
        NavigationStack {
            VStack {
                customInputView(title: "Word", value: $wordValue)
                
                Divider()
                    .background(Color.white)
                    .padding(.leading)
                
                customInputView(title: "Meaning", value: $meaningValue)
                
                Button {
                    dismiss()
                    onAddCardTapped?()
                } label: {
                    Text("Add card")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            Color("DP")
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding()
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Add Card")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color("DP"))
                            .fontWeight(.medium)
                    }

                }
            }
        }
        .colorScheme(.dark)
        
    }
    
    @ViewBuilder
    private func customInputView(title: String, value: Binding<String>) -> some View {
        VStack {
            
            Text(title)
                .foregroundStyle(Color("LP"))
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(title, text: value)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.white, lineWidth: 0.8)
                )
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    AddCardView()
}
