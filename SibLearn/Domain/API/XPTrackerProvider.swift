//
//  XPTrackerProvider.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData

public protocol XPTrackerProvider: Actor {
    
    func getTotalXp() async throws -> Int
    func updateTotalXp(_ xp: Int) async throws
}
