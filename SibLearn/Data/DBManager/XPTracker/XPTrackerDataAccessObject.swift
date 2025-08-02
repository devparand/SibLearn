//
//  XPTrackerDataAccessObject.swift
//  SibLearn
//
//  Created by Parsa on 8/1/25.
//

import Foundation
import SwiftData

/// Contains every `XP Tracker` database operations like `insert`, `fetch`. `update` and `delete`
public final class XPTrackerDataAccessObject: @unchecked Sendable {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    @MainActor
    public func getTotalXP() throws -> Int {
        let descriptor = FetchDescriptor<XPTrackerEntity>()
        return try context.fetch(descriptor).first.map {
            $0.totalXP
        } ?? 0
    }
    
    @MainActor
    public func updateTotalXP(_ totalXP: Int) throws {
        if let existingXPTrackerEntity = try context.fetch(FetchDescriptor<XPTrackerEntity>()).first {
            if existingXPTrackerEntity.totalXP == 0 { context.insert(existingXPTrackerEntity) }
            existingXPTrackerEntity.totalXP = totalXP
        }
        else {
            let entity = XPTrackerEntity(totalXP: totalXP)
            context.insert(entity)
        }
    }
}
