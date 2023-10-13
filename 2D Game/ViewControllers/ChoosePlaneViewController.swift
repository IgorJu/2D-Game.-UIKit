//
//  ChoosePlaneViewController.swift
//  2D Game
//
//  Created by Igor on 09.10.2023.
//

import UIKit

final class ChoosePlaneViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var planeImageView: UIImageView!
    
    private let gameManager = GameManager.shared
    private let storageManager = StorageManager.shared
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planeImageView.image = UIImage(named: storageManager.loadString(key: .plane) ?? "plane")
        setupGradient()
    }
    
    //MARK: - flow

    @IBAction func chooseJetPlane() {
        changePlaneImage(imageName: PlaneImageNames.jetPlane)
    }
    
    @IBAction func chooseAirbus() {
        changePlaneImage(imageName: PlaneImageNames.airbus)
    }
    
    @IBAction func chooseGreenPlane() {
        changePlaneImage(imageName: PlaneImageNames.greenPlane)
    }
    
    @IBAction func chosePlaneTapped() {
        dismiss(animated: true)
    }
    
    private func changePlaneImage(imageName: String) {
        planeImageView.image = UIImage(named: imageName)
        gameManager.changePlaneImage(imageName: imageName)
        storageManager.saveString(imageName, key: .plane)
    }
}

//MARK: - Enum plane image names

private enum PlaneImageNames {
    static let airbus = "plane"
    static let jetPlane = "jetPlane"
    static let greenPlane = "greenPlane"
}
