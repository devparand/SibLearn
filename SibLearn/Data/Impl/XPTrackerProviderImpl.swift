//
//  XPTrackerProviderImpl.swift
//  SibLearn
//
//  Created by Parsa on 7/31/25.
//

import Foundation
import SwiftData
import ComposableArchitecture

/// An implementation class for implement our protocol in Domain API
/// This is a bridge between Domain And Data layer with its protocol `XPTrackerProvider`
public final actor XPTrackerProviderImpl: XPTrackerProvider, @unchecked Sendable {

    private let xpTrackerDataAccessObject: XPTrackerDataAccessObject
    
    public init(xpTrackerDataAccessObject: XPTrackerDataAccessObject) {
        self.xpTrackerDataAccessObject = xpTrackerDataAccessObject
    }
    
    public func getTotalXp() async throws -> Int {
        return try await xpTrackerDataAccessObject.getTotalXP()
    }
    
    public func updateTotalXp(_ xp: Int) async throws {
        try await xpTrackerDataAccessObject.updateTotalXP(xp)
    }
    
    
}
