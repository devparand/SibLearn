//
//  FlashCardSchema.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation

///Model of Flash Card as a bridge with Data and Domain Layer
public struct FlashCardSchema: Hashable, Sendable {
    
    let id: String
    let word: String
    let meaning: String
    let isCorrect: Bool?
    let createdAt: Int
    
    init(id: String, word: String, meaning: String, isCorrect: Bool?, createdAt: Int) {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.isCorrect = isCorrect
        self.createdAt = createdAt
    }
    
    ///We have immutable properties, so we need copy function to create a new model without change any properties.
    func copy(id: String? = nil, word: String? = nil, meaning: String? = nil, isCorrect: Bool? = nil, createdAt: Int? = nil) -> Self {
        return .init(id: id ?? self.id, word: word ?? self.word, meaning: meaning ?? self.meaning, isCorrect: isCorrect ?? self.isCorrect, createdAt: createdAt ?? self.createdAt)
    }
}
