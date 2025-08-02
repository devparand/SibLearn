//
//  XPTrackerSchema.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation

public struct XPTrackerSchema: Hashable, Sendable {
    let id: String
    let totalXP: Int
    
    init(id: String, totalXP: Int) {
        self.id = id
        self.totalXP = totalXP
    }
    
    func copy(id: String? = nil, totalXP: Int? = nil) -> Self {
        return .init(id: id ?? self.id, totalXP: totalXP ?? self.totalXP)
    }
}
