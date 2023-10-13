//
//  ChooseEnemyViewController.swift
//  2D Game
//
//  Created by Igor on 11.10.2023.
//

import UIKit

final class ChooseEnemyViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var enemyImageView: UIImageView!
    
    private let gameManager = GameManager.shared
    private let storageManager = StorageManager.shared
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enemyImageView.image = gameManager.fetchEnemyImage()
        setupGradient()
    }
    
    //MARK: -  Flow
    
    @IBAction func spaceShipTapped() {
        changeEnemyImage(imageName: EnemyImageNames.spaceShip)
    }
    
    @IBAction func armyJetTapped() {
        changeEnemyImage(imageName: EnemyImageNames.armyJet)
    }
    
    @IBAction func yellowPlaneTapped() {
        changeEnemyImage(imageName: EnemyImageNames.yellowPlane)
    }
    
    
    @IBAction func chooseEnemyTapped() {
        dismiss(animated: true)
    }
    
    private func changeEnemyImage(imageName: String) {
        enemyImageView.image = UIImage(named: imageName)
        gameManager.changeEnemyImage(imageName: imageName)
        storageManager.saveString(imageName, key: .enemy)
    }
}

//MARK: enum Enemy image names
private enum EnemyImageNames {
    static let spaceShip = "spaceship"
    static let armyJet = "aircraft"
    static let yellowPlane = "enemy"
}
