//
//  ChooseSpeedViewController.swift
//  2D Game
//
//  Created by Igor on 11.10.2023.
//

import UIKit

class ChooseSpeedViewController: UIViewController {

    private let gameManager = GameManager.shared
    private let storageManager = StorageManager.shared
    
    private var speedGame = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        speedGame = gameManager.fetchSpeed()
    }

    @IBAction func slowSpeedTapped() {
        changeSpeed(SpeedGame.slow)
    }
    
    
    @IBAction func mediumSpeedTapped() {
        changeSpeed(SpeedGame.medium)
        
    }
    
    @IBAction func fastSpeedTapped() {
        changeSpeed(SpeedGame.fast)
    }
    
    @IBAction func chooseSpeedTapped() {
        dismiss(animated: true)
    }
    
    private func changeSpeed(_ speed: Double) {
        speedGame = speed
        gameManager.changeSpeed(speed)
        storageManager.saveDouble(speed, key: .speed)
    }
}

private enum SpeedGame {
    static let slow = 8.0
    static let medium = 5.0
    static let fast = 2.0
}
