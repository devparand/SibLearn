//
//  XPTrackerEntity.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import SwiftData
import Foundation

@Model
final class XPTrackerEntity: @unchecked Sendable {
    var id: String = UUID().uuidString
    var totalXP: Int = 0

    init(totalXP: Int = 0) {
        self.totalXP = totalXP
    }
}
