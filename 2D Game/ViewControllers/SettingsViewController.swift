//
//  SettingsViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userPhotoImageView: UIImageView!
    
    
    @IBOutlet var chooseAirplane: UIButton!
    @IBOutlet var chooseObstacle: UIButton!
    @IBOutlet var chooseSpeedGame: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
    }
    
    
    
}
