//
//  ChooseSpeedViewController.swift
//  2D Game
//
//  Created by Igor on 11.10.2023.
//

import UIKit

final class ChooseSpeedViewController: UIViewController {

    //MARK: - Properties
    
    private let gameManager = GameManager.shared
    private let storageManager = StorageManager.shared
    
    private var speedGame = 0.0
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        speedGame = gameManager.fetchSpeed()
    }

    //MARK: - Flow
    @IBAction func slowSpeedTapped() {
        changeSpeed(SpeedOfGame.slow)
    }
    
    @IBAction func mediumSpeedTapped() {
        changeSpeed(SpeedOfGame.medium)
    }
    
    @IBAction func fastSpeedTapped() {
        changeSpeed(SpeedOfGame.fast)
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

//MARK: - Enum speedGame
private enum SpeedOfGame {
    static let slow = 8.0
    static let medium = 5.0
    static let fast = 2.0
}
