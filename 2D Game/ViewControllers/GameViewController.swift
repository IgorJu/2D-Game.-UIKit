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
        callObstacle()
        
    }
    
    @IBAction func leftButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.airplaneView.frame.origin.x -= 40
            self.view.layoutIfNeeded()
        })
        
    }
    
    @IBAction func rightButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.airplaneView.frame.origin.x += 40
            self.view.layoutIfNeeded()
        })
        
    }
    
    func addNewImageView() {
        let xObstacle = Int.random(in: 60...250)
        let yObstacle = 0
        let obstacle = UIImageView(image: UIImage(named: "plane-2"))
        obstacle.frame = CGRect(x: xObstacle, y: yObstacle, width: 50, height: 50)
        view.addSubview(obstacle)
        
        UIView.animate(withDuration: 3, animations: {
            obstacle.frame = CGRect(x: obstacle.frame.origin.x, y: self.view.frame.height, width: 60, height: 60)
        }, completion: { (finished) in
            obstacle.removeFromSuperview()
        })
        
        
        let cloud = UIImageView(image: UIImage(named: "cloud"))
        let xCloud = Int.random(in: 60...250)
        cloud.frame = CGRect(x: xCloud, y: 30, width: 40, height: 40)
        view.addSubview(cloud)
        
        UIView.animate(withDuration: 15, animations: {
            cloud.frame = CGRect(x: cloud.frame.origin.x, y: self.view.frame.height, width: 40, height: 40)
        }, completion: { (finished) in
            cloud.removeFromSuperview()
        })
        
        let cloudTwo = UIImageView(image: UIImage(named: "cloud"))
        cloudTwo.frame = CGRect(x: Int.random(in: 60...250), y: 30, width: 40, height: 40)
        view.addSubview(cloudTwo)
        
        UIView.animate(withDuration: 15, animations: {
            cloudTwo.frame = CGRect(x: cloudTwo.frame.origin.x, y: self.view.frame.height, width: 40, height: 40)
        }, completion: { (finished) in
            cloudTwo.removeFromSuperview()
        })

    
        
        airplaneView.frame = CGRect(
            x: airplaneView.frame.origin.x,
            y: airplaneView.frame.origin.y,
            width: airplaneView.frame.size.width,
            height: airplaneView.frame.size.height
        )
    }
    
    
    func callObstacle() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            self.addNewImageView()
        }
    }
    
    
}









