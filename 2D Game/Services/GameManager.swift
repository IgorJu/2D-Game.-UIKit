//
//  GameManager.swift
//  2D Game
//
//  Created by Igor on 05.10.2023.
//

import UIKit

class GameManager {
    
    private var records: [Record] = []
    
    private var userPlane = UIImage()
    
    static let shared = GameManager()
    
    private init() { }

    func reportCollision(record: Record) {
        records.append(record)
    }
    
    func fetchRecords() -> [Record] {
        records.sorted { $0.scores > $1.scores }
    }
    
    func changePlaneImage(imageName: String) {
        userPlane = UIImage(named: imageName) ?? UIImage()
        StorageManager.shared.saveString(imageName, key: .plane)
    }
    
    func fetchImagePlane() -> UIImage {
        userPlane = UIImage(named: StorageManager.shared.loadString(key: .plane) ?? "plane") ?? UIImage()
        return userPlane
    }
}
