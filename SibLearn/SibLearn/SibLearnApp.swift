//
//  SibLearnApp.swift
//  SibLearn
//
//  Created by Parsa on 7/30/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct SibLearnApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView(
                store: Store(initialState: FlashCardFeature.State()) {
                    FlashCardFeature()
                }
            )
        }
    }
}
