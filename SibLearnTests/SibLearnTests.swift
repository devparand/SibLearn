//
//  SibLearnTests.swift
//  SibLearnTests
//
//  Created by Parsa on 8/2/25.
//

import Testing
import ComposableArchitecture
import SnapshotTesting
import SwiftData
@testable import SibLearn

struct SibLearnTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test
    @MainActor func testCorrectAnswerIncreasesXP() async throws {
        let container = try ModelContainer(
            for: FlashCardEntity.self, XPTrackerEntity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )

        let flashCard = FlashCardEntity(word: "Apple", meaning: "سیب")
        let schema = FlashCardSchema(id: flashCard.id, word: flashCard.word, meaning: flashCard.meaning, isCorrect: nil, createdAt: .now)
        container.mainContext.insert(flashCard)
        container.mainContext.insert(XPTrackerEntity(totalXP: 0))

        let store = TestStore(initialState: FlashCardFeature.State()) {
            FlashCardFeature()
        } withDependencies: {
            $0.flashCardProvider = FlashCardProviderImpl(flashCardDataAccessObject: FlashCardDataAccessObject(context: container.mainContext))
            $0.xpTrackerProvider = XPTrackerProviderImpl(xpTrackerDataAccessObject: XPTrackerDataAccessObject(context: container.mainContext))
        }
        store.exhaustivity = .off
        
        await store.send(.fetchFlashCards)
        
        await store.receive(\.flashCardsReceived) { state in
            state.flashCards = [schema.toDomain()]
        }
        
        await store.send(.checkAnswer(schema.toDomain(), "سیب"))
        
        await store.receive(\.updateFlashCard) { state in
            let newSchema = schema.copy(isCorrect: true)
            state.flashCards = [newSchema.toDomain()]
        }
        
        await store.receive(\.receiveTotalXp) { state in
            state.totalXP = 10
        }
    }
    
    //MARK: If you run test and take the error about record issue u have to run the test again and you will see the test is passed - this is the note of this library
    @Test
    @MainActor func testHomeViewPreview() async throws {
        let homeView = HomeView(
                        store: Store(initialState: FlashCardFeature.State()) {
                            FlashCardFeature()
                            }
                        )
        withSnapshotTesting(record: .never, diffTool: .ksdiff) {
            assertSnapshot(of: homeView, as: .image(layout: .device(config: .iPhone13), traits: .iPhone13(.portrait)), record: false)
        }
        
        
    }

}
