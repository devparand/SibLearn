//
//  FlashCardProvider.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData
import Combine

public protocol FlashCardProvider: Actor, Sendable {
    func getFlashCards() async throws -> [FlashCard]
    func addFlashCard(flashCard: FlashCard) async throws
    func updateFlashCard(flashCard: FlashCard) async throws
    func getFlashCardPublisher() -> AnyPublisher<FlashCard, Never>
}
