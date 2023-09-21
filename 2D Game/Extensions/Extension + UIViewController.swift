//
//  Extension + UIViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

extension UIViewController {
    
func setupGradient() {
    let startColor = UIColor(
        red: 34 / 255,
        green: 85 / 255,
        blue: 205 / 255,
        alpha: 1
    )
    
    let endColor = UIColor(
        red: 209 / 255,
        green: 239 / 255,
        blue: 252 / 255,
        alpha: 1.0
    )

    view.addVerticalGradientLayer(topColor: endColor, bottomColor: startColor)
}
}
