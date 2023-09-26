//
//  GameViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var airplaneView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        UIView.animate(withDuration: 5) {
            self.airplaneView.frame.origin.y = self.view.frame.height - 50
            
        }
    }
    
    


}
