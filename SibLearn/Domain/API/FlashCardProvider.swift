//
//  FlashCardProvider.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData
import Combine

public protocol FlashCardProvider: Actor {
    func getFlashCards() throws -> [FlashCard]
    func addFlashCard(flashCard: FlashCard) throws
    func updateFlashCard(flashCard: FlashCard) throws
    func getFlashCardPublisher() -> AnyPublisher<FlashCard, Never>
}
