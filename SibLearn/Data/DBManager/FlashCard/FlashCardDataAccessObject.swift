//
//  FlashCardDataAccessObject.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData
import Combine

/// Contains every `Flash Card` database operations like `insert`, `fetch`. `update` and `delete`
public final class FlashCardDataAccessObject: @unchecked Sendable {
    
    private let context: ModelContext
    
    public let flashCardPublisher = PassthroughSubject<FlashCardSchema, Never>()
    
    init(context: ModelContext) {
        self.context = context
    }
    
    public func getFlashCards() throws -> [FlashCardSchema] {
        try DispatchQueue.main.sync {
            let descriptor = FetchDescriptor<FlashCardEntity>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
            return try context.fetch(descriptor).map {
                createSchema(from: $0)
            }
        }
    }
    
    public func addFlashCard(_ flashCard: FlashCardSchema) throws {
        try DispatchQueue.main.sync {
            let word = flashCard.word
            let predicate = #Predicate<FlashCardEntity> {
                $0.word == word
            }
            let descriptor = FetchDescriptor<FlashCardEntity>(predicate: predicate, sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
            if let entity = try context.fetch(descriptor).first {
                entity.word = flashCard.word
                entity.meaning = flashCard.meaning
                entity.isCorrect = nil
                entity.createdAt = Int(Date().timeIntervalSince1970)
                try context.save()
                flashCardPublisher.send(createSchema(from: entity))
            }
            else {
                let entity = FlashCardEntity(word: flashCard.word, meaning: flashCard.meaning)
                context.insert(entity)
                try context.save()
                flashCardPublisher.send(createSchema(from: entity))
            }

        }
    }
    
    public func updateFlashCard(_ flashCard: FlashCardSchema) throws {
        try DispatchQueue.main.sync {
            let word = flashCard.word
            let predicate = #Predicate<FlashCardEntity> {
                $0.word == word
            }
            let descriptor = FetchDescriptor<FlashCardEntity>(predicate: predicate, sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
            guard let entity = try context.fetch(descriptor).first else {
                return
            }
            entity.isCorrect = flashCard.isCorrect
            try context.save()
        }
    }
}

//MARK: Private Functions
extension FlashCardDataAccessObject {
    
    private func createSchema(from entity: FlashCardEntity) -> FlashCardSchema {
        return FlashCardSchema(id: entity.id, word: entity.word, meaning: entity.meaning, isCorrect: entity.isCorrect, createdAt: entity.createdAt)
    }
    
}
