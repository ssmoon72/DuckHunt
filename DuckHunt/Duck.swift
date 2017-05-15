//
//  Duck.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import Foundation
import SpriteKit

class Duck: SKSpriteNode, GameSprite {
    var initialSize = CGSize(width: 64, height: 36)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var flyAnimation = SKAction()
    var deathAnimation = SKAction()
    
    // duck sound effects
    let duckDeathSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
    
    init() {
        let duckTexture = textureAtlas.textureNamed("green-duck-fly-1")
        super.init(texture: nil, color: .clear, size: initialSize)
        
        createAnimations()
        self.run(flyAnimation, withKey: "flyAnimation")
        
        self.physicsBody = SKPhysicsBody(texture: duckTexture, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func createAnimations() {
        let flyFrame: [SKTexture] = [
            textureAtlas.textureNamed("green-duck-fly-1"),
            textureAtlas.textureNamed("green-duck-fly-2"),
            textureAtlas.textureNamed("green-duck-fly-3"),
            textureAtlas.textureNamed("green-duck-fly-2")
        ]
        let dieFrame: [SKTexture] = [
            textureAtlas.textureNamed("green-duck-die-1"),
            textureAtlas.textureNamed("green-duck-die-2"),
            textureAtlas.textureNamed("green-duck-die-3"),
            textureAtlas.textureNamed("green-duck-die-4"),
            textureAtlas.textureNamed("green-duck-die-5"),
            textureAtlas.textureNamed("green-duck-die-2"),
            textureAtlas.textureNamed("green-duck-die-3"),
            textureAtlas.textureNamed("green-duck-die-4")
        ]
        let flyAction = SKAction.animate(with: flyFrame, timePerFrame: 0.08)
        flyAnimation = SKAction.repeatForever(flyAction)
        
        let deathAction = SKAction.animate(with: dieFrame, timePerFrame: 0.1)
        deathAnimation = SKAction.repeat(deathAction, count: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func onTap() {}
    
    func die() {
        self.removeAction(forKey: "flyAnimation")
        self.run(deathAnimation)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.categoryBitMask = 0
        self.run(duckDeathSound)
    }
}

