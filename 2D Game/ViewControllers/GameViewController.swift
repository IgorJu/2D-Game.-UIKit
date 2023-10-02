//
//  GameViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet var airplaneView: UIImageView!
    
    @IBOutlet var scoresLabel: UILabel!
    
    private var scores = 0
    
    private var gameTimer: Timer? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
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
    
  private func setAirplaneFrame() {
        airplaneView.frame.origin.x = view.frame.midX - airplaneView.frame.width * 0.5
        airplaneView.frame.origin.y = view.frame.maxY * 0.8
    }
    
   private func addStormView() {
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
   private func addEnemyPlanes() {
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
            self.checkAcross(enemy: enemy)
            enemy.removeFromSuperview()
        })
    }
    
    //MARK:  Clouds
   private func addClouds() {
        
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
    
   private func callObstacle() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            self?.addEnemyPlanes()
            self?.addStormView()
            self?.addClouds()
        }
    }
    
   private func checkAcross(enemy: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            if let airplanePresentedFrame = self?.airplaneView.layer.presentation()?.frame,
               let enemyFrame = enemy.layer.presentation()?.frame {
                let airplaneX = airplanePresentedFrame.origin.x
                let enemyX = enemyFrame.origin.x
                let airplaneWidth = airplanePresentedFrame.size.width
                
                if (airplaneX < enemyX + Constants.smallImageSize && airplaneX + airplaneWidth > enemyX) {
                    self?.alert()
                }
            }
        }
    }
    
    private func alert() {
        gameTimer?.invalidate()
        let alert = UIAlertController(
            title: "Игра окончена.\nВы набрали \(scores) очков",
            message: "",
            preferredStyle: .alert
        )
        
        
        alert.addAction(
            UIAlertAction(
                title: "Начать заново",
                style: .default,
                handler: { [weak self] _ in
                    self?.restartGame()
                }
            )
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

   private func startGame() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
    }
    
    @objc func updateGame() {
        scores += 1
        updateScoreLabel()
        
    }
    
    func updateScoreLabel() {
        scoresLabel.text = "Очков: \(scores)"
    }
    
    private func restartGame() {
        // Восстановите начальные значения и очистите экран
        scores = 0
        updateScoreLabel()
        clearScreen()
        
        // Запустите игру снова
        startGame()
        callObstacle()
    }
    
    private func clearScreen() {
        for subview in view.subviews {
            subview.removeFromSuperview()
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








