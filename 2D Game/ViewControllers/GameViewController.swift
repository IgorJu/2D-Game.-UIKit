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
    
    private let gameManager = GameManager.shared
    private let storageManager = StorageManager.shared
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        airplaneView.image = gameManager.fetchPlaneImage()
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
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        isGameOver = true
        finishGame()
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - FLOW
    
    private func setAirplaneFrame() {
        airplaneView.frame.origin.x = view.frame.midX - airplaneView.frame.width * 0.5
        airplaneView.frame.origin.y = view.frame.maxY * 0.8
    }
    
    //MARK: setup collision
    
    func checkCollision(enemy: UIView) -> Bool  {
        var checkCollission = false
        if let enemyPresentedFrame = enemy.layer.presentation()?.frame,
           let presentedFrame = self.airplaneView.layer.presentation()?.frame {
            
            let planeX = presentedFrame.origin.x
            let enemyX = enemyPresentedFrame.origin.x
            
            let planeY = presentedFrame.origin.y
            let enemyY = enemyPresentedFrame.origin.y
            
            let planeYBottom = presentedFrame.origin.y + presentedFrame.height
            let enemyYBottom = enemyPresentedFrame.origin.y + enemyPresentedFrame.height
            
            if planeX - enemyX < enemyPresentedFrame.width
                && enemyX - planeX < enemyPresentedFrame.width
                && planeY - enemyYBottom < .zero
                && planeYBottom  - enemyY > -presentedFrame.height
                || planeX < Constants.distanceFromTheSide
                || view.frame.width - planeX - presentedFrame.width < Constants.distanceFromTheSide {
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
                    finishGame()
                    alert()
                }
            }
        }
    }
    
    //MARK:  Alert
    private func alert() {
        var existingRecords = storageManager.loadRecords() ?? []
        
        gameManager.reportCollision(record: Record(scores: scores))
        existingRecords.append(User(
            name: storageManager.loadString(key: .user) ?? "",
            record: Record(scores: scores),
            imageName: storageManager.loadString(key: .avatar) ?? ""
        ))
        
        storageManager.saveRecords(existingRecords)
        
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
        
        alert.addAction(
            UIAlertAction(
                title: "Закончить игру",
                style: .cancel,
                handler:  { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:  game life cycle, updating values
    
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
    
    private func finishGame() {
        enemyAnimator?.stopAnimation(true)
        enemyAnimator?.finishAnimation(at: .current)
        
        cloudAnimator?.stopAnimation(true)
        cloudAnimator?.finishAnimation(at: .current)
        
        gameTimer?.invalidate()
    }
    
    
    private func updateScoreLabel() {
        scoresLabel.text = "Счет: \(scores)"
    }
    
    @objc func updateGame() {
        scores += 1
        updateScoreLabel()
    }
}

//MARK: - Extension + create and add animations
extension GameViewController {
    private func addEnemyPlanes() {
        let xRandomSpawn = Double.random(in: 30...280)
        let enemy = UIImageView(image: gameManager.fetchEnemyImage())
        self.enemies.append(enemy)
        
        enemy.frame = CGRect(
            x: xRandomSpawn,
            y: Constants.ySpawn,
            width: Constants.enemySize,
            height: Constants.enemySize
        )
        view.addSubview(enemy)
        
        enemyAnimator = UIViewPropertyAnimator(duration: gameManager.fetchSpeed(), curve: .linear) {
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
        var stepBetweenClouds = 0.0
        
        for _ in 1...5 {
            let cloud = UIImageView(image: UIImage(named: GameImageNames.cloud))
            cloud.frame = CGRect(
                x: Double.random(in: 30...280),
                y: Constants.ySpawn - stepBetweenClouds,
                width: Constants.smallImageSize,
                height: Constants.smallImageSize
            )
            self.clouds.append(cloud)
            self.view.addSubview(cloud)
            
            stepBetweenClouds += Constants.stepBetweenClouds
        }
        
        cloudAnimator = UIViewPropertyAnimator(
            duration: (storageManager.loadDouble(key: .speed) ?? Constants.objectDuration) * Constants.multiplierDuration ,
            curve: .linear
        ) {
            self.clouds.forEach { cloud in
                cloud.frame = CGRect(
                    x: cloud.frame.origin.x,
                    y: self.view.frame.height + stepBetweenClouds,
                    width: Constants.smallImageSize,
                    height: Constants.smallImageSize
                )
                cloud.alpha = 0
            }
        }
        
        cloudAnimator?.addCompletion { [weak self] (_) in
            self?.clouds.forEach { $0.removeFromSuperview() }
            self?.cloudAnimator = nil
            self?.clouds.removeAll()
            self?.addClouds()
        }
        cloudAnimator?.startAnimation()
    }
}








