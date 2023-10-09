//
//  ChoosePlaneViewController.swift
//  2D Game
//
//  Created by Igor on 09.10.2023.
//

import UIKit

class ChoosePlaneViewController: UIViewController {

    @IBOutlet var planeImageView: UIImageView!
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
    }

    @IBAction func chooseJetPlane(_ sender: Any) {
        planeImageView.image = UIImage(named: PlaneImageNames.jetPlane)
    }
    
    @IBAction func chooseAirbus(_ sender: Any) {
        planeImageView.image = UIImage(named: PlaneImageNames.airbus)
    }
    
    
    @IBAction func chooseGreenPlane(_ sender: Any) {
        planeImageView.image = UIImage(named: PlaneImageNames.greenPlane)
    }
    
    
    
}


private enum PlaneImageNames {
    static let airbus = "plane"
    static let jetPlane = "jetPlane"
    static let greenPlane = "greenPlane"
}
