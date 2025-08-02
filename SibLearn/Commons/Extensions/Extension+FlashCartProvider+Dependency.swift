//
//  extension.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData
import Dependencies

public extension DependencyValues {
    
    private static let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FlashCardEntity.self,
            XPTrackerEntity.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    enum FlashCardProviderKey: DependencyKey {
       public static let liveValue: FlashCardProvider = {
           let context = ModelContext(DependencyValues.sharedModelContainer)
           let dao = FlashCardDataAccessObject(context: context)
           return FlashCardProviderImpl(flashCardDataAccessObject: dao)
       }()
        
        public static let testValue: FlashCardProvider = {
            let context = ModelContext(DependencyValues.sharedModelContainer)
            let dao = FlashCardDataAccessObject(context: context)
            return FlashCardProviderImpl(flashCardDataAccessObject: dao)
        }()
    }
    
    var flashCardProvider: FlashCardProvider {
        get { self[FlashCardProviderKey.self] }
        set { self[FlashCardProviderKey.self] = newValue }
    }
}

