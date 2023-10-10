//
//  Record.swift
//  2D Game
//
//  Created by Igor on 24.09.2023.
//

import Foundation

struct Record: Codable, Comparable {
    static func < (lhs: Record, rhs: Record) -> Bool {
        return lhs.scores > rhs.scores
    }
    
    let scores: Int
}

