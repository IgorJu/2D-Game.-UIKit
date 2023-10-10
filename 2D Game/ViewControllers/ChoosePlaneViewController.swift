//
//  ChoosePlaneViewController.swift
//  2D Game
//
//  Created by Igor on 09.10.2023.
//

import UIKit

class ChoosePlaneViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var planeImageView: UIImageView!
    
    private let gameManager = GameManager.shared
    private let storageManager = StorageManager.shared
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        planeImageView.image = UIImage(named: storageManager.loadString(key: .plane) ?? "enemy")
        setupGradient()
    }
    
    //MARK: - flow

    @IBAction func chooseJetPlane() {
        planeImageView.image = UIImage(named: PlaneImageNames.jetPlane)
        gameManager.changePlaneImage(imageName: PlaneImageNames.jetPlane)
        storageManager.saveString(PlaneImageNames.jetPlane, key: .plane)
    }
    
    @IBAction func chooseAirbus() {
        planeImageView.image = UIImage(named: PlaneImageNames.airbus)
        gameManager.changePlaneImage(imageName: PlaneImageNames.airbus)
        storageManager.saveString(PlaneImageNames.airbus, key: .plane)
    }
    
    @IBAction func chooseGreenPlane() {
        planeImageView.image =  UIImage(named: PlaneImageNames.greenPlane)
         gameManager.changePlaneImage(imageName: PlaneImageNames.greenPlane)
        storageManager.saveString(PlaneImageNames.greenPlane, key: .plane)
    }
    
    @IBAction func chosePlaneTapped() {
        dismiss(animated: true)
    }
}


private enum PlaneImageNames {
    static let airbus = "plane"
    static let jetPlane = "jetPlane"
    static let greenPlane = "greenPlane"
}
