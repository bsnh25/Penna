//
//  GameScene.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 14/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //    var starAnimate: SKEmitterNode?
    //    var writeField: SKFieldNode?
    var enemies = Enemies()
    var gameTimer: Timer?
    var player: SKSpriteNode!
    var score: Int = 0
    var totalScore:Int  = 0
    //
    var sentences = ["saya", "adalah", "seorang", "kapiten"]
    var currentWordIndex = 0
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupPlayer()
        setupPortal()
    
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(makeEnemies), userInfo: nil, repeats: true)
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
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
    
    func setupBackground(){
        let background = SKSpriteNode(imageNamed: "classRoom")
        background.zPosition = -1
        background.size.width = size.width
        background.size.height = size.height
        //        background.position = CGPoint(x: 0.0, y: 1.0)
        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        addChild(background)
    }
    
    func setupPlayer(){
        player = SKSpriteNode(imageNamed: "player")
        player.zPosition = 1
        player.size.width = 100
        player.size.height = 450
        player.position = CGPoint(x: size.width/8, y: size.height/3)
        addChild(player)
    }
    
    func setupPortal(){
        let portal = SKSpriteNode(imageNamed: "portal")
        portal.zPosition = 1
        portal.size.width = 100
        portal.size.height = 600
        portal.position = CGPoint(x: size.width - 100, y: size.height/2)
        addChild(portal)
    }
    
    @objc func makeEnemies() {
            guard currentWordIndex < sentences.count else {
                gameTimer?.invalidate()
                return
            }
            
            let word = sentences[currentWordIndex]
            currentWordIndex += 1

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
