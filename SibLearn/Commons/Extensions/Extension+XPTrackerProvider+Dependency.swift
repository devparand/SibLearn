//
//  Extension+XPTrackerProvider+Dependency.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//

import Foundation

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
    
    enum XPTrackerProviderKey: DependencyKey {
       public static let liveValue: XPTrackerProvider = {
           let context = ModelContext(DependencyValues.sharedModelContainer)
           let dao = XPTrackerDataAccessObject(context: context)
           return XPTrackerProviderImpl(xpTrackerDataAccessObject: dao)
       }()
    }
    
    var xpTrackerProvider: XPTrackerProvider {
        get { self[XPTrackerProviderKey.self] }
        set { self[XPTrackerProviderKey.self] = newValue }
    }
}
