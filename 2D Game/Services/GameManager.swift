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
    
    private var users: [User] = []
    
    private let storageManager = StorageManager.shared
    
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
        storageManager.saveString(imageName, key: .plane)
    }
    
    func fetchPlaneImage() -> UIImage {
        userPlane = UIImage(named: storageManager.loadString(key: .plane) ?? "plane") ?? UIImage()
        return userPlane
    }
    
    //MARK: - enemy plane methods
    
    func changeEnemyImage(imageName: String) {
        enemyPlane = UIImage(named: imageName) ?? UIImage()
        storageManager.saveString(imageName, key: .enemy)
    }
    
    func fetchEnemyImage() -> UIImage {
        enemyPlane = UIImage(named: storageManager.loadString(key: .enemy) ?? "aircraft") ?? UIImage()
        return enemyPlane
    }
    
    //MARK: - speed game methods
    
    func changeSpeed(_ speed: Double) {
        speedGame = speed
        storageManager.saveDouble(speed, key: .speed)
    }
    
    
    func fetchSpeed() -> Double {
        speedGame = storageManager.loadDouble(key: .speed) ?? Constants.enemyDuration
        return speedGame
    }
    
    func fetchUsers() -> [User] {
        self.users = self.storageManager.loadRecords() ?? []
        return users
    }
    
}
