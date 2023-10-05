//
//  GameManager.swift
//  2D Game
//
//  Created by Igor on 05.10.2023.
//

import Foundation


class GameManager {
    
    private var records: [Record] = []
    
    static let shared = GameManager()
    
    private init() { }

    func reportCollision(record: Record) {
        records.append(record)
    }
    
    func fetchRecords() -> [Record] {
        records
    }
}
