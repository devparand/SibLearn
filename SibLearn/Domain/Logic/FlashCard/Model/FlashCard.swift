//
//  FlashCard.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//


public struct FlashCard: Identifiable, Hashable, Sendable {
    
    public let id: String
    public let word: String
    public let meaning: String
    public let isCorrect: Bool?
    public let createdAt: Int
    
    public init(id: String, word: String, meaning: String, isCorrect: Bool?, createdAt: Int) {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.isCorrect = isCorrect
        self.createdAt = createdAt
    }
    
    public func copy(id: String? = nil, word: String? = nil, meaning: String? = nil, isCorrect: Bool? = nil, createdAt: Int? = nil) -> Self {
        return .init(id: id ?? self.id, word: word ?? self.word, meaning: meaning ?? self.meaning, isCorrect: isCorrect ?? self.isCorrect, createdAt: createdAt ?? self.createdAt)
    }
}
