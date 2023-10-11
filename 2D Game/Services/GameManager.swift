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
    private var enemyPlane = UIImage()
    
    private var speedGame = Constants.enemyDuration
    
    static let shared = GameManager()
    
    private init() { }

    func reportCollision(record: Record) {
        records.append(record)
    }
    
    func fetchRecords() -> [Record] {
        records.sorted { $0.scores > $1.scores }
    }
    
    //MARK: - user plane methods
    
    func changePlaneImage(imageName: String) {
        userPlane = UIImage(named: imageName) ?? UIImage()
        StorageManager.shared.saveString(imageName, key: .plane)
    }

    func fetchPlaneImage() -> UIImage {
        userPlane = UIImage(named: StorageManager.shared.loadString(key: .plane) ?? "plane") ?? UIImage()
        return userPlane
    }
    
    //MARK: - enemy plane methods
    
    func changeEnemyImage(imageName: String) {
        enemyPlane = UIImage(named: imageName) ?? UIImage()
        StorageManager.shared.saveString(imageName, key: .enemy)
    }
    
    func fetchEnemyImage() -> UIImage {
        enemyPlane = UIImage(named: StorageManager.shared.loadString(key: .enemy) ?? "aircraft") ?? UIImage()
        return enemyPlane
    }
    
    
    //MARK: - speed game methods
    
    func changeSpeed(_ speed: Double) {
        speedGame = speed
        StorageManager.shared.saveDouble(speed, key: .speed)
    }

    
    func fetchSpeed() -> Double {
        speedGame = StorageManager.shared.loadDouble(key: .speed) ?? Constants.enemyDuration
        return speedGame
    }
    
    
}
