//
//  GameScene.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 14/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameTimer: Timer?
    var player: SKSpriteNode!
    var sentences: [String] = []
//    var currentWordIndex = 0
    
    var drawingViewController: DrawingViewController?
    var backgroundPosition : CGFloat = 0
    
    var currentLevel: LevelDictionary = .level_1
    var currentStrokeType: StrokeType = .oneStroke // Default stroke type for level 2
    
    
    override func didMove(to view: SKView) {
        
        // Initialize DrawingViewController
        drawingViewController = DrawingViewController()
        
        if let drawingVC = drawingViewController {
            drawingVC.view.frame = self.view!.bounds
            drawingVC.view.backgroundColor = .clear
            
            // Add DrawingViewController's view as a subview of SKView
            self.view?.addSubview(drawingVC.view)
        }
        
        setupBackground()
        setupPlayer()
        setupPortal()
        setupSentences()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(makeEnemies), userInfo: nil, repeats: true)
        
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
        
        print(size.height)
        print((size.height-(drawingViewController?.canvasHeight ?? size.height * 1/3)))
        print(size.width)
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
    
    func setupSentences() {
        switch currentLevel {
        case .level_1, .level_3, .level_4, .level_5, .level_6:
            sentences = currentLevel.term
        case .level_2:
            sentences = currentLevel.terms(for: currentStrokeType)
        }
    }
    
    @objc func makeEnemies() {
        //        guard currentWordIndex < sentences.count else {
        //            gameTimer?.invalidate()
        //            return
        //        }
        
        guard !sentences.isEmpty else {
            gameTimer?.invalidate()
            return
        }
        
        let randomIndex = Int.random(in: 0..<sentences.count)
        let word = sentences[randomIndex]
//        currentWordIndex += 1
        
        let sprite = SKLabelNode(text: word)
        sprite.fontName = "Arial"
        sprite.fontSize = 24
        sprite.fontColor = SKColor.black
        sprite.position = CGPoint(x: size.width - 100, y: CGFloat.random(in: size.height / 2...size.height))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.frame.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.linearDamping = 0
        
        let direction = CGVector(dx: player.position.x - sprite.position.x, dy: player.position.y - sprite.position.y)
        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
        let normalizedDirection = CGVector(dx: direction.dx / length, dy: direction.dy / length)
        let speed: CGFloat = 200.0
        sprite.physicsBody?.velocity = CGVector(dx: normalizedDirection.dx * speed, dy: normalizedDirection.dy * speed)
    }
}

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
