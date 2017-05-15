//
//  Crosshair.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode, GameSprite {
    var initialSize: CGSize = CGSize(width: 24, height: 24)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Crosshair")
    var shooting = SKAction()
    let MAX_LIVES = 3
    var lives = 3
    
    var coolDownAction = SKAction()
    
    var coolDown = false
    
    let missedShotSound = SKAction.playSoundFileNamed("missed-shot.mp3", waitForCompletion: false)
    
    init() {
        let crosshairTexture = textureAtlas.textureNamed("crosshair")
        super.init(texture: crosshairTexture, color: .clear, size: initialSize)
        // places crosshair above every other texture
        self.zPosition = 1
//        self.physicsBody = SKPhysicsBody(texture: crosshairTexture, size: self.size)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = 3.0
        
        // setting up physics categories (collisons/contact)
        self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update() {
    }
    
    func onTap() {}
    
    func shotAnimation() {
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.05)
        let scaleDown = SKAction.scale(to: 1, duration: 0.05)
        shooting = SKAction.sequence([scaleUp, scaleDown])
        self.run(shooting)
    }
    
    func miss() {
        self.lives -= 1
        self.run(missedShotSound)
    }
}
    
//    func shotTaken() {
//        if self.coolDown { return }
//        self.coolDown = true
//        
//        self.run(self.coolDownAction)
//    }
    
//    func coolDownSequence() {
//        print("cooling down")
//        let coolDownStart = SKAction.run {
//            self.physicsBody?.categoryBitMask = PhysicsCategory.playerShot.rawValue
//        }
//        let fadeOut = SKAction.fadeAlpha(to: 0.3, duration: 0.3)
//        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.3)
//        let coolDownEnd = SKAction.run {
//            self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
//            self.coolDown = false
//        }
//        self.coolDownAction = SKAction.sequence([
//            coolDownStart,
//            fadeOut,
//            fadeIn,
//            coolDownEnd
//        ])
//        
//    }
    

    



