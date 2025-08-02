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
    
    public func getTotalXP() throws -> Int {
        try DispatchQueue.main.sync {
            let descriptor = FetchDescriptor<XPTrackerEntity>()
            return try context.fetch(descriptor).first.map {
                $0.totalXP
            } ?? 0
        }
    }
    
    public func updateTotalXP(_ totalXP: Int) throws {
        try DispatchQueue.main.sync {
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
}
