//
//  AddCardView.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftUI
import ComposableArchitecture

struct AddCardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let store: StoreOf<AddCardFeature>
    
    init(store: StoreOf<AddCardFeature>) {
        self.store = store
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                WithViewStore(store, observe: \.self) { viewStore in
                    customInputView(title: "Word", value: viewStore.binding(get: { state in
                        state.wordValue
                    }, send: { value in
                            .setWordValue(value)
                    }))
                    
                    Divider()
                        .background(Color.white)
                        .padding(.leading)
                    
                    customInputView(title: "Meaning", value: viewStore.binding(get: { state in
                        state.meaningValue
                    }, send: { value in
                            .setMeaningValue(value)
                    }))
                    
                    addFlashCardButton(isDisabled: viewStore.state.wordValue.isEmpty || viewStore.state.meaningValue.isEmpty) {
                        viewStore.send(.addFlashCard(word: viewStore.state.wordValue, meaning: viewStore.state.meaningValue))
                    }
                    .onChange(of: viewStore.isAddingFlashCard) { oldValue, newValue in
                        dismiss()
                    }
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
    private func addFlashCardButton(isDisabled: Bool, onTap: @escaping () -> Void) -> some View {
        Button {
            onTap()
        } label: {
            Text("Add card")
                .foregroundStyle(Color.white)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    ZStack {
                        if isDisabled {
                            Color.gray
                        }
                        else {
                            Color("DP")
                        }
                            
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
        }
        .disabled(isDisabled)
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
    AddCardView(
        store: Store(initialState: AddCardFeature.State()) {
            AddCardFeature()
        }
    )
}
