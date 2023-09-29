//
//  GameViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

private enum constants {
    static let moveToSide = 40.0
    static let bigImageSize = 50.0
    static let smallImageSize = 40.0
    static let ySpawn = -50.0
}

class GameViewController: UIViewController {
    @IBOutlet var airplaneView: UIImageView!
    
    private var initialAirplaneFrame: CGRect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        callObstacle()
    }
    
    @IBAction func leftButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.airplaneView.frame.origin.x -= constants.moveToSide
        })
        
    }
    
    
    
    @IBAction func rightButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.airplaneView.frame.origin.x += constants.moveToSide
        })
        
    }
    
    func addStormView() {
        //MARK: Left storm
        
        let leftStorm = UIImageView(image: UIImage(named: "storm-2"))
        leftStorm.frame = CGRect(
            x: .zero,
            y: constants.ySpawn,
            width: constants.bigImageSize,
            height: constants.bigImageSize
        )
        view.addSubview(leftStorm)
        
        UIView.animate(withDuration: 9, animations: {
            leftStorm.frame = CGRect(
                x: leftStorm.frame.origin.x,
                y: self.view.frame.height + constants.bigImageSize,
                width: constants.bigImageSize,
                height: constants.bigImageSize
            )
        }, completion: { (finished) in
            leftStorm.removeFromSuperview()
        })
        //MARK: RightStorm
        let xRightStorm = view.frame.width - constants.bigImageSize
        
        let rightStorm = UIImageView(image: UIImage(named: "storm-2"))
        rightStorm.frame = CGRect(
            x: xRightStorm,
            y: constants.ySpawn,
            width: constants.bigImageSize,
            height: constants.bigImageSize
        )
        view.addSubview(rightStorm)
        
        UIView.animate(withDuration: 9, delay: 1, animations: {
            rightStorm.frame = CGRect(
                x: rightStorm.frame.origin.x,
                y: self.view.frame.height + constants.bigImageSize,
                width: constants.bigImageSize,
                height: constants.bigImageSize
            )
        }, completion: { (finished) in
            rightStorm.removeFromSuperview()
        })
    }
    
    
    //MARK: Enemy planes
    func addEnemyPlanes() {
        let xRandomSpawn = Double.random(in: 60...250)
        let enemy = UIImageView(image: UIImage(named: "plane-2"))
        enemy.frame = CGRect(
            x: xRandomSpawn,
            y: constants.ySpawn,
            width: constants.bigImageSize,
            height: constants.bigImageSize
        )
        view.addSubview(enemy)
        
        UIView.animate(withDuration: 3, animations: {
            enemy.frame = CGRect(
                x: enemy.frame.origin.x,
                y: self.view.frame.height + constants.bigImageSize,
                width: constants.bigImageSize,
                height: constants.bigImageSize
            )
        }, completion: { (finished) in
            enemy.removeFromSuperview()
        })
    }
    
//MARK:  Clouds
    func addClouds() {
        
        let cloud = UIImageView(image: UIImage(named: "cloud"))
        cloud.frame = CGRect(
            x: Double.random(in: 60...250),
            y: constants.ySpawn,
            width: constants.smallImageSize,
            height: constants.smallImageSize
        )
        
        view.addSubview(cloud)
        
        UIView.animate(withDuration: 15, animations: {
            cloud.frame = CGRect(
                x: cloud.frame.origin.x,
                y: self.view.frame.height + constants.bigImageSize,
                width: constants.smallImageSize,
                height: constants.smallImageSize
            )
        }, completion: { (finished) in
            cloud.removeFromSuperview()
        })
        
        let cloudTwo = UIImageView(image: UIImage(named: "cloud"))
        
        cloudTwo.frame = CGRect(
            x:  Double.random(in: 60...250),
            y: constants.ySpawn,
            width: constants.smallImageSize,
            height: constants.smallImageSize
        )
        
        view.addSubview(cloudTwo)
        
        UIView.animate(withDuration: 15, delay: 2,  animations: {
            cloudTwo.frame = CGRect(
                x: cloudTwo.frame.origin.x,
                y: self.view.frame.height + constants.bigImageSize,
                width: constants.smallImageSize,
                height: constants.smallImageSize
            )
        }, completion: { (finished) in
            cloudTwo.removeFromSuperview()
        })
    }
    
    
    func callObstacle() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.addEnemyPlanes()
            self.addStormView()
            self.addClouds()
        }
    }
    
    
}









