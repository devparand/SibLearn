//
//  FlashCardProviderImpl.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData
import Combine

/// An implementation class for implement our protocol in Domain API
/// This is a bridge between Domain And Data layer with its protocol `FlashCardProvider`
public final actor FlashCardProviderImpl: FlashCardProvider, @unchecked Sendable {

    private let flashCardDataAccessObject: FlashCardDataAccessObject
    
    init(flashCardDataAccessObject: FlashCardDataAccessObject) {
        self.flashCardDataAccessObject = flashCardDataAccessObject
    }
    
    public func getFlashCards() throws -> [FlashCard] {
        return try flashCardDataAccessObject.getFlashCards().map { $0.toDomain() }
    }
    
    public func addFlashCard(flashCard: FlashCard) throws {
        try flashCardDataAccessObject.addFlashCard(flashCard.toSchema())
    }
    
    public func updateFlashCard(flashCard: FlashCard) throws {
        try flashCardDataAccessObject.updateFlashCard(flashCard.toSchema())
    }
    
    public func getFlashCardPublisher() -> AnyPublisher<FlashCard, Never> {
        return flashCardDataAccessObject.flashCardPublisher
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
