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
        setAirplaneFrame()
        setupGradient()
        callObstacle()
    }
    
    @IBAction func leftButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.airplaneView.frame.origin.x -= Constants.moveToSide
        }
    }
    
    @IBAction func rightButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.airplaneView.frame.origin.x += Constants.moveToSide
        }
    }
    
    func setAirplaneFrame() {
        airplaneView.frame.origin.x = view.frame.midX - airplaneView.frame.width * 0.5
        airplaneView.frame.origin.y = view.frame.maxY * 0.8
}
    
    func addStormView() {
        //MARK: Left storm
        
        let leftStorm = UIImageView(image: UIImage(named: GameImageNames.storm))
        leftStorm.frame = CGRect(
            x: .zero,
            y: Constants.ySpawn,
            width: Constants.bigImageSize,
            height: Constants.bigImageSize
        )
        view.addSubview(leftStorm)
        
        
        UIView.animate(withDuration: 9, animations: {
            leftStorm.frame = CGRect(
                x: leftStorm.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.bigImageSize,
                height: Constants.bigImageSize
            )
        }, completion: { (finished) in
            leftStorm.removeFromSuperview()
        })
        //MARK: RightStorm
        let xRightStorm = view.frame.width - Constants.bigImageSize
        let rightStorm = UIImageView(image: UIImage(named: GameImageNames.storm))
        
        rightStorm.frame = CGRect(
            x: xRightStorm,
            y: Constants.ySpawn,
            width: Constants.bigImageSize,
            height: Constants.bigImageSize
        )
        view.addSubview(rightStorm)
        
        UIView.animate(withDuration: 9, delay: 1, animations: {
            rightStorm.frame = CGRect(
                x: rightStorm.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.bigImageSize,
                height: Constants.bigImageSize
            )
        }, completion: { (finished) in
            rightStorm.removeFromSuperview()
        })
    }
    
    
    //MARK: Enemy planes
    func addEnemyPlanes() {
        let xRandomSpawn = Double.random(in: 60...250)
        let enemy = UIImageView(image: UIImage(named: GameImageNames.enemy))
        enemy.frame = CGRect(
            x: xRandomSpawn,
            y: Constants.ySpawn,
            width: Constants.bigImageSize,
            height: Constants.bigImageSize
        )
        view.addSubview(enemy)
        
        UIView.animate(withDuration: 3, animations: {
            enemy.frame = CGRect(
                x: enemy.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.bigImageSize,
                height: Constants.bigImageSize
            )
        }, completion: { (finished) in
            enemy.removeFromSuperview()
        })
    }
    
//MARK:  Clouds
    func addClouds() {
        
        let cloud = UIImageView(image: UIImage(named: GameImageNames.cloud))
        cloud.frame = CGRect(
            x: Double.random(in: 60...250),
            y: Constants.ySpawn,
            width: Constants.smallImageSize,
            height: Constants.smallImageSize
        )
        
        view.addSubview(cloud)
        
        UIView.animate(withDuration: 15, animations: {
            cloud.frame = CGRect(
                x: cloud.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.smallImageSize,
                height: Constants.smallImageSize
            )
        }, completion: { (finished) in
            cloud.removeFromSuperview()
        })
        
        let cloudTwo = UIImageView(image: UIImage(named: GameImageNames.cloud))
        
        cloudTwo.frame = CGRect(
            x:  Double.random(in: 60...250),
            y: Constants.ySpawn,
            width: Constants.smallImageSize,
            height: Constants.smallImageSize
        )
        
        view.addSubview(cloudTwo)
        
        UIView.animate(withDuration: 15, delay: 2,  animations: {
            cloudTwo.frame = CGRect(
                x: cloudTwo.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.smallImageSize,
                height: Constants.smallImageSize
            )
        }, completion: { (finished) in
            cloudTwo.removeFromSuperview()
        })
    }
    
    func callObstacle() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            self?.addEnemyPlanes()
            self?.addStormView()
            self?.addClouds()
        }
    }
    
    
}

fileprivate enum Constants {
    static let moveToSide = 40.0
    static let bigImageSize = 50.0
    static let smallImageSize = 40.0
    static let ySpawn = -50.0
}

fileprivate enum GameImageNames {
    static let enemy = "plane-2"
    static let cloud = "cloud"
    static let storm = "storm-2"
}








