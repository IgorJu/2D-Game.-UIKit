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
    
    private var enemyAnimator: UIViewPropertyAnimator?
    private var cloudAnimator: UIViewPropertyAnimator?
    
    private var enemies: [UIImageView] = []
    private var storms: [UIImageView] = []
    private var clouds: [UIImageView] = []
    
    private var isGameOver = false
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setAirplaneFrame()
        createDisplayLink()
        startGame()
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
    
    
    func checkCollision(enemy: UIView) -> Bool  {
        var checkCollission = false
        if let enemyPresentedFrame = enemy.layer.presentation()?.frame,
           let presentedFrame = self.airplaneView.layer.presentation()?.frame {
            
            let planeX = presentedFrame.origin.x
            let enemyX = enemyPresentedFrame.origin.x
            
            let planeY = presentedFrame.origin.y
            let enemyYBottom = enemyPresentedFrame.origin.y + enemyPresentedFrame.height
            
            if planeX - enemyX < Constants.enemySize
                && enemyX - planeX < Constants.enemySize
                && planeY - enemyYBottom < 0 {
                checkCollission = true
            }
        }
        return checkCollission
    }
    
    private func createDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: .default)
    }
    
    @objc private func step(displayLink: CADisplayLink) {
        if isGameOver {
            return
        } else {
            enemies.forEach { enemy in
                if checkCollision(enemy: enemy) {
                    enemyAnimator?.stopAnimation(true)
                    enemyAnimator?.finishAnimation(at: .current)
                    
                    cloudAnimator?.stopAnimation(true)
                    cloudAnimator?.finishAnimation(at: .current)
                    
                    gameTimer?.invalidate()
                    alert()
                }
            }
        }
    }
    
    //MARK:  Alert
    private func alert() {
        GameManager.shared.reportCollision(record: Record(scores: scores))
        isGameOver = true
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
                    self?.dismiss(animated: true) {
                        self?.enemies.forEach { $0.removeFromSuperview() }
                        self?.enemies.removeAll()
                        
                        self?.clouds.forEach { $0.removeFromSuperview() }
                        self?.clouds.removeAll()
                    }
                    self?.restartGame()
                }
                
            )
        )
        
        alert.addAction(UIAlertAction(title: "Закончить игру", style: .cancel, handler:  { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func startGame() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        addEnemyPlanes()
        addClouds()
    }
    
    private func restartGame() {
        isGameOver = false
        scores = 0
        setAirplaneFrame()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        addEnemyPlanes()
        addClouds()
        
    }
    
    private func updateScoreLabel() {
        scoresLabel.text = "Счет: \(scores)"
    }
    
    @objc func updateGame() {
        scores += 1
        updateScoreLabel()
    }
}

private enum Constants {
    static let moveToSide = 40.0
    static let enemySize = 60.0
    static let bigImageSize = 50.0
    static let smallImageSize = 40.0
    static let ySpawn = -50.0
    static let enemyDuration = 3.0
    static let objectDuration = 10.0
}

private enum GameImageNames {
    static let enemy = "enemy"
    static let cloud = "cloud"
    static let storm = "storm-2"
}

extension GameViewController {
    private func addEnemyPlanes() {
        let xRandomSpawn = Double.random(in: 60...250)
        let enemy = UIImageView(image: UIImage(named: GameImageNames.enemy))
        self.enemies.append(enemy)
        
        enemy.frame = CGRect(
            x: xRandomSpawn,
            y: Constants.ySpawn,
            width: Constants.enemySize,
            height: Constants.enemySize
        )
        view.addSubview(enemy)
        
        enemyAnimator = UIViewPropertyAnimator(duration: Constants.enemyDuration, curve: .linear) {
            enemy.frame = CGRect(
                x: enemy.frame.origin.x,
                y: self.view.frame.height + Constants.enemySize,
                width: Constants.enemySize,
                height: Constants.enemySize
            )
        }
        enemyAnimator?.addCompletion { [weak self] (_) in
            enemy.removeFromSuperview()
            self?.enemies.removeAll()
            self?.enemyAnimator = nil
            self?.addEnemyPlanes()
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
        
        cloudAnimator = UIViewPropertyAnimator(duration: Constants.objectDuration, curve: .linear) {
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
            self?.clouds.removeAll()
            self?.addClouds()
        }
        
        cloudAnimator?.startAnimation()
    }
}








