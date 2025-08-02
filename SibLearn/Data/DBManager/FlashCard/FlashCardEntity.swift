//
//  FlashCardEntity.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftData
import Foundation

@Model
final class FlashCardEntity: @unchecked Sendable {
    
    var id = UUID().uuidString
    var word: String
    var meaning: String
    var isCorrect: Bool?
    var createdAt: Int
    
    init(word: String, meaning: String, isCorrect: Bool? = nil, createAt: Int = .now) {
        self.word = word
        self.meaning = meaning
        self.isCorrect = isCorrect
        self.createdAt = createAt
    }
}
