//
//  GameScene.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 14/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameVM = GameViewModel()
    var player: SKSpriteNode!
    var drawingViewController: DrawingViewController?
    var backgroundPosition : CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        drawingViewController = DrawingViewController()
        
        if let skView = self.view {
            if let drawingVC = drawingViewController {
                drawingVC.view.frame = skView.bounds
                drawingVC.view.backgroundColor = .clear
                drawingVC.gameVM = gameVM
                self.view?.addSubview(drawingVC.view)
            }
        }
        
        setupBackground()
        setupPlayer()
        setupPortal()
        gameVM.setupSentences()
        
        gameVM.gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(makeEnemies), userInfo: nil, repeats: true)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setupBackground(){
        let background = SKSpriteNode(imageNamed: "classRoom")
        backgroundPosition = drawingViewController?.canvasHeight ?? size.height*1/3
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        background.size = CGSize(width: size.width, height: size.height - backgroundPosition)
        background.position = CGPoint(x: 0, y: backgroundPosition)
        addChild(background)
    }
    
    func setupPlayer(){
        player = SKSpriteNode(imageNamed: "player")
        player.zPosition = 1
        player.size = CGSize(width: 100, height: 300)
        player.position = CGPoint(x: size.width/10, y: size.height - backgroundPosition - 80)
        addChild(player)
    }
    
    func setupPortal(){
        let portal = SKSpriteNode(imageNamed: "portal")
        portal.zPosition = 1
        portal.size = CGSize(width: 100, height: 400)
        portal.position = CGPoint(x: size.width - 100, y: size.height - backgroundPosition)
        addChild(portal)
    }
    
    @objc func makeEnemies() {
        
        guard !gameVM.sentences.isEmpty else {
            gameVM.gameTimer?.invalidate()
            return
        }
        
        let wordEnemy = gameVM.generateWordEnemy()
        
        let enemy = SKLabelNode(text: wordEnemy)
        enemy.fontName = "Arial"
        enemy.fontSize = 24
        enemy.fontColor = SKColor.black
        enemy.position = CGPoint(x: size.width - 100, y: CGFloat.random(in: size.height / 2...size.height))
        enemy.name = "enemy"
        enemy.zPosition = 1
        addChild(enemy)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.frame.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.linearDamping = 0
        
        let direction = CGVector(dx: player.position.x - enemy.position.x, dy: player.position.y - enemy.position.y)
        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
        let normalizedDirection = CGVector(dx: direction.dx / length, dy: direction.dy / length)
        let speed: CGFloat = 200.0
        enemy.physicsBody?.velocity = CGVector(dx: normalizedDirection.dx * speed, dy: normalizedDirection.dy * speed)
    }
}

//extension GameScene: ShootProtocol {
//    func shootTheText(_ text: String) {
//        // Create an enemy label node
//        let enemy = SKLabelNode(text: text)
//        enemy.fontName = "Arial"
//        enemy.fontSize = 24
//        enemy.fontColor = .black
//        enemy.position = CGPoint(x: size.width - 100, y: CGFloat.random(in: size.height / 2...size.height))
//        enemy.name = "enemy"
//        enemy.zPosition = 1
//        addChild(enemy)
//
//        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.frame.size)
//        enemy.physicsBody?.affectedByGravity = false
//        enemy.physicsBody?.linearDamping = 0
//
//        // Calculate direction towards the player
//        let direction = CGVector(dx: player.position.x - enemy.position.x, dy: player.position.y - enemy.position.y)
//        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
//        let normalizedDirection = CGVector(dx: direction.dx / length, dy: direction.dy / length)
//        let speed: CGFloat = 200.0
//        enemy.physicsBody?.velocity = CGVector(dx: normalizedDirection.dx * speed, dy: normalizedDirection.dy * speed)
//    }
//}


// <! Ini Enemy Balok>
//    @objc func makeEnemies() {
//        let enemy = SKSpriteNode(imageNamed: "block")
//        enemy.position = CGPoint(x: Int(size.width-100), y: Int.random(in: Int(size.height / 2)...Int(size.height)))
//        enemy.name = "enemy"
//        enemy.zPosition = 1
//        enemy.size.width = 100
//        enemy.size.height = 100
//        addChild(enemy)
//
//        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
//        enemy.physicsBody?.affectedByGravity = false
//        enemy.physicsBody?.linearDamping = 0
//
//        // Calculate the direction towards the player
//        let direction = CGVector(dx: player.position.x - enemy.position.x, dy: player.position.y - enemy.position.y)
//        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
//        let normalizedDirection = CGVector(dx: direction.dx / length, dy: direction.dy / length)
//
//        // Set the velocity towards the player
//        var speed: CGFloat {
//            if score >= Int(1/3 * totalScore) {
//                return 100
//            } else if score >= 2/3*totalScore {
//                return 150
//            } else {
//                return 50
//            }
//        }
//
//        enemy.physicsBody?.velocity = CGVector(dx: normalizedDirection.dx * speed, dy: normalizedDirection.dy * speed)
//    }
