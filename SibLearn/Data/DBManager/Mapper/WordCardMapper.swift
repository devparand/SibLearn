//
//  WordCardMapper.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation

extension FlashCardSchema {
    
    func toDomain() -> FlashCard {
        return FlashCard(id: id, word: word, meaning: meaning, isCorrect: isCorrect, createdAt: createdAt)
    }
    
}

extension FlashCard {
    
    func toSchema() -> FlashCardSchema {
        return FlashCardSchema(id: id, word: word, meaning: meaning, isCorrect: isCorrect, createdAt: createdAt)
    }
    
}
