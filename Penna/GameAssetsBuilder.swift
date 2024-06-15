//
//  Enemies.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 15/06/24.
//

import Foundation
import SpriteKit

class Enemies: SKScene {
    
    func makeEnemies(){
        let sprite = SKSpriteNode(imageNamed: "block")
        sprite.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
        
    }
    
}
