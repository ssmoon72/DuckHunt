//
//  GameScene.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//
import SpriteKit
import GameplayKit
import CoreMotion


class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    
    let player = Player()
    
    // core motion manager
    let motionManager = CMMotionManager()
    
    let hud = HUD()

    
    var isShooting = false
    var isContact = false
    let duckDeathSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
    
    var score = 0
    
    override func didMove(to view: SKView) {
        AudioManager.instance.playBackgroundMusic()
        self.anchorPoint = .zero
       // self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "duck_hunt_background.png")!)
        
        hud.createHUDNodes(screenSize: self.size)
        self.addChild(hud)
        
        
        // Prevents things from going off the screen
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        player.position = CGPoint(x: 150, y: 150)
        self.addChild(player)
        
        // starting motion manager
        self.motionManager.startAccelerometerUpdates()
        
        // set up game scene for contact events
        self.physicsWorld.contactDelegate = self
        
        // spawn enemies
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(GameScene.spawnEnemy), userInfo: nil, repeats: true)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
        
        // unwrapper accelerometer data
        if let accelData = self.motionManager.accelerometerData {
            var movement = CGVector()
            let forceAmountY: CGFloat = 15
            let forceAmountX: CGFloat = 30
            
            // tilting left and right
            if accelData.acceleration.y > 0.10 {
                movement.dx = -forceAmountX
            }
            else if accelData.acceleration.y < -0.10 {
                movement.dx = forceAmountX
            }
            
            // tilting up and down
            if accelData.acceleration.x > -0.3 {
                movement.dy = forceAmountY
            }
            else if accelData.acceleration.x < -0.6 {
                movement.dy = -forceAmountY
            }
            
            player.physicsBody?.applyForce(movement)
        }
        
        hud.updateLives(newLives: player.lives)
    }

    
    // DEALING WITH TAPPING SCREEN *******/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = false
        player.shotAnimation()
        isShooting = true
        if isContact {
            print("hit but nothing happened")
        } else {
            print("missed")
            player.miss()
            
            // transition to Game Over Scene
            if player.lives == 0 {
                let scene = GameOverScene(fileNamed: "GameOver");
                scene?.score = self.score
                self.view?.presentScene(scene!, transition:SKTransition.doorsOpenVertical(withDuration: 1))
            }
//            hud.updateLives(newLives: player.lives)
        }
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.01),
            SKAction.run {
                self.player.physicsBody?.contactTestBitMask = ~PhysicsCategory.enemy.rawValue
                self.isContact = false
            },
            SKAction.wait(forDuration: 0.75),
            SKAction.run {
                self.player.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue
                self.isUserInteractionEnabled = true
            }
            ]))
        isContact = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isShooting = false
        isContact = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isShooting = false
        isContact = false
    }
    /************************************/
    
    
    // runs when two physics bodies come in contact
    func didBegin(_ contact: SKPhysicsContact) {
        isContact = true
        let otherBody: SKPhysicsBody
        let crosshairMask = PhysicsCategory.player.rawValue
        
        // setting one of the bodies as the "other" body (not the player)
        if (contact.bodyA.categoryBitMask & crosshairMask) > 0 {
            otherBody = contact.bodyB
        }
        else {
            otherBody = contact.bodyA
        }
        
        // checks collison
        if isShooting && otherBody.categoryBitMask > 0 {
            // check if otherBody was an enemy
            if otherBody.categoryBitMask == PhysicsCategory.enemy.rawValue {
                // unwraps the otherBody node to run duck methods
                if let duck = otherBody.node as? Duck {
                    print("hit duck")
                    duck.die()
                    self.score += 1
                    player.lives = player.MAX_LIVES
//                    hud.updateLives(newLives: player.lives)
                    hud.updateScore(newScoreCount: self.score)
                }
            }
        }
    }
    
    // checks when contact between two objects ends
    func didEnd(_ contact: SKPhysicsContact) {
        isContact = false
        let otherBody:SKPhysicsBody
        let crosshairMask = PhysicsCategory.player.rawValue
        
        if (contact.bodyA.categoryBitMask & crosshairMask) > 0 {
            otherBody = contact.bodyB
        }
        else {
            otherBody = contact.bodyA
        }
        
        // makes sure that end of contact was with an enemy
        if otherBody.categoryBitMask > 0 {
            if otherBody.categoryBitMask == PhysicsCategory.enemy.rawValue {
            }
        }
    }
        
        
        
        // USE SWITCH CASE FOR MULTIPLE TARGETS
//        switch otherBody.categoryBitMask {
//        case PhysicsCategory.enemy.rawValue:
//            if isShooting {
//                print("hit duck")
//            } else {
//                print("missed")
//            }
//        default:
//            print("contact with no game logic")
//        }

    
    // generates random entry point for ducks
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // spawn an Enemy
    func spawnEnemy() {
        var yPos = CGFloat(0.0)
        let enemy = Duck()
        let speedX = randomBetweenNumbers(firstNum: 9, secondNum: 14 )
        let speedY = randomBetweenNumbers(firstNum: -2, secondNum: 2)
        if (speedY < 0) {
            yPos = randomBetweenNumbers(firstNum: frame.height / 2, secondNum: frame.height - 50)
        } else {
            yPos = randomBetweenNumbers(firstNum: 50, secondNum: frame.height / 2)
        }
        enemy.position = CGPoint(x: 0, y: yPos)
        self.addChild(enemy)
        
        enemy.physicsBody?.applyImpulse(CGVector(dx: speedX, dy: speedY))
    }
    
}

// set up categories for collision/contact
enum PhysicsCategory: UInt32 {
    case player = 1
    case playerShot = 2
    case enemy = 4
    case deadEnemy = 8
}







