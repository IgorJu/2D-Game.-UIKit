//
//  Extension + UITableViewController.swift
//  2D Game
//
//  Created by Igor on 24.09.2023.
//

import UIKit
extension UITableViewController {
    
    func setupGradientTable() {
        let primaryColor = UIColor(
            red: 34 / 255,
            green: 85 / 255,
            blue: 205 / 255,
            alpha: 1
        )
        
        let secondaryColor = UIColor(
            red: 209 / 255,
            green: 239 / 255,
            blue: 252 / 255,
            alpha: 1.0
        )
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tableView.bounds
        gradientLayer.colors = [primaryColor.cgColor,secondaryColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        tableView.backgroundView = backgroundView
    }
}

