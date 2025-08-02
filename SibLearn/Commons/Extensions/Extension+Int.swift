//
//  Extension+Int.swift
//  SibLearn
//
//  Created by Parsa on 8/2/25.
//

import Foundation

extension Int {
    static var now: Int {
        return Int(Date().timeIntervalSince1970)
    }
}
