//
//  GameViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet var airplaneView: UIImageView!
    
    @IBOutlet var scoresLabel: UILabel!
    
    private var scores = 0
    private var gameTimer: Timer? = nil
    
    
    private var stormAnimator: UIViewPropertyAnimator?
    private var enemyAnimator: UIViewPropertyAnimator?
    private var cloudAnimator: UIViewPropertyAnimator?
    
    private var enemies: [UIImageView] = []
    
    private var clouds: [UIImageView] = []
    
    private var storms: [UIImageView] = []
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        createDisplayLink()
        setAirplaneFrame()
        setupGradient()
    }
    //MARK: - IBActions
    
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
    
    //MARK: - FLOW
    
    private func setAirplaneFrame() {
        airplaneView.frame.origin.x = view.frame.midX - airplaneView.frame.width * 0.5
        airplaneView.frame.origin.y = view.frame.maxY * 0.8
    }
    
    private func callObstacle() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            self?.addEnemyPlanes()
            self?.addStormView()
            self?.addClouds()
        }
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
        storms.append(leftStorm)
        view.addSubview(leftStorm)
        
        stormAnimator = UIViewPropertyAnimator(duration: 9, curve: .linear) {
            leftStorm.frame = CGRect(
                x: leftStorm.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.bigImageSize,
                height: Constants.bigImageSize
            )
        }
        stormAnimator?.addCompletion { [weak self] (_) in
            leftStorm.removeFromSuperview()
            self?.stormAnimator = nil
        }
        stormAnimator?.startAnimation()
        
        
        //MARK: RightStorm
        let xRightStorm = view.frame.width - Constants.bigImageSize
        let rightStorm = UIImageView(image: UIImage(named: GameImageNames.storm))
        
        rightStorm.frame = CGRect(
            x: xRightStorm,
            y: Constants.ySpawn,
            width: Constants.bigImageSize,
            height: Constants.bigImageSize
        )
        storms.append(rightStorm)
        view.addSubview(rightStorm)
        
        stormAnimator = UIViewPropertyAnimator(duration: 9, curve: .linear) {
            rightStorm.frame = CGRect(
                x: rightStorm.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.bigImageSize,
                height: Constants.bigImageSize
            )
        }
        stormAnimator?.addCompletion { [weak self] (_) in
            leftStorm.removeFromSuperview()
            self?.stormAnimator = nil
        }
        stormAnimator?.startAnimation()
    }
    
    
    //MARK: Enemy planes
    private func addEnemyPlanes() {
        let xRandomSpawn = Double.random(in: 60...250)
        let enemy = UIImageView(image: UIImage(named: GameImageNames.enemy))
        self.enemies.append(enemy)
        
        enemy.frame = CGRect(
            x: xRandomSpawn,
            y: Constants.ySpawn,
            width: Constants.bigImageSize,
            height: Constants.bigImageSize
        )
        view.addSubview(enemy)
        
        enemyAnimator = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            enemy.frame = CGRect(
                x: enemy.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.bigImageSize,
                height: Constants.bigImageSize
            )
        }
        enemyAnimator?.addCompletion { [weak self] (_) in
            enemy.removeFromSuperview()
            self?.enemies.removeAll()
            self?.enemyAnimator = nil
        }
        enemyAnimator?.startAnimation()
                
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
        clouds.append(cloud)
        
        view.addSubview(cloud)
        
        cloudAnimator = UIViewPropertyAnimator(duration: 15, curve: .linear) {
            cloud.frame = CGRect(
                x: cloud.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.smallImageSize,
                height: Constants.smallImageSize
            )
        }
        cloudAnimator?.addCompletion { [weak self] (_) in
            cloud.removeFromSuperview()
            self?.cloudAnimator = nil
        }
        
        cloudAnimator?.startAnimation()
        
        //        if isCollision {
        //            cloudAnimator?.stopAnimation(true)
        //            cloudAnimator = nil
        //        }
        
        let cloudTwo = UIImageView(image: UIImage(named: GameImageNames.cloud))
        
        cloudTwo.frame = CGRect(
            x:  Double.random(in: 60...250),
            y: Constants.ySpawn,
            width: Constants.smallImageSize,
            height: Constants.smallImageSize
        )
        clouds.append(cloudTwo)
        
        view.addSubview(cloudTwo)
        
        cloudAnimator = UIViewPropertyAnimator(duration: 15, curve: .linear){
            cloudTwo.frame = CGRect(
                x: cloudTwo.frame.origin.x,
                y: self.view.frame.height + Constants.bigImageSize,
                width: Constants.smallImageSize,
                height: Constants.smallImageSize
            )
        }
        cloudAnimator?.addCompletion { [weak self] (_) in
            cloudTwo.removeFromSuperview()
            self?.cloudAnimator = nil
        }
        cloudAnimator?.startAnimation()
        //        if isCollision {
        //            cloudAnimator?.stopAnimation(true)
        //            cloudAnimator = nil
        //        }
    }
    
    
    private func checkCollision(enemy: UIView) -> Bool {
        // DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
        if let airplanePresentedFrame = airplaneView.layer.presentation()?.frame,
           let enemyFrame = enemy.layer.presentation()?.frame {
            let airplaneX = airplanePresentedFrame.origin.x
            let enemyX = enemyFrame.origin.x
            let airplaneWidth = airplanePresentedFrame.size.width
            
            if airplaneX < enemyX + Constants.smallImageSize &&
                airplaneX + airplaneWidth > enemyX &&
                airplanePresentedFrame.minY - enemyFrame.maxY < 10 {

                
                return true
                //setAirplaneFrame()
            }
//            if (airplaneX < 70 && view.frame.width - airplaneX - airplaneWidth < 70 ) {
//
//                return true
//                //setAirplaneFrame()
//            }
       }
        return false
    }
    
    
    private func createDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: .default)
    }
    
    @objc private func step(displayLink: CADisplayLink) {
        
        enemies.forEach { enemy in
            
            if checkCollision(enemy: enemy) {
                enemyAnimator?.stopAnimation(true)
                enemyAnimator = nil
                enemy.removeFromSuperview()
                enemies.removeAll(where: { $0 === enemy })
                
                cloudAnimator?.stopAnimation(true)
                cloudAnimator = nil
                clouds.forEach { $0.removeFromSuperview() }
                clouds.removeAll()
                
                
                stormAnimator?.stopAnimation(true)
                stormAnimator = nil
                storms.forEach { $0.removeFromSuperview() }
                storms.removeAll()
                
                
            }
            //alert()
            //setAirplaneFrame()
        }
        
    }
    
    //MARK:  Alert
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
                    //self?.restartGame()
                }
            )
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    private func startGame() {
        callObstacle()
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
        GameManager.shared.reportCollision(record: Record(scores: scores))
        scores = 0
        updateScoreLabel()
        startGame()
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








