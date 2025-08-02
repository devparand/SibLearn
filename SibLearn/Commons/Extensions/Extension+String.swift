//
//  Extension+String.swift
//  SibLearn
//
//  Created by Parsa on 8/2/25.
//

import Foundation

extension String {
    
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
}
