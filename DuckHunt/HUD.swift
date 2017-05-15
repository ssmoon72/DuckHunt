//
//  HUD.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import SpriteKit

class HUD: SKNode {
    var textureAtlas = SKTextureAtlas(named: "HUD")
    // array to keep track of lives
    var lifeNodes:  [SKSpriteNode] = []
    let scoreText = SKLabelNode(text: "SCORE: ")
    let scoreCountText = SKLabelNode(text: "000")
    
    
    func createHUDNodes(screenSize: CGSize) {
        scoreText.fontName = "AvenirNext-HeavyItalic"
        scoreCountText.fontName = "AvenirNext-HeavyItalic"
        
        // setting up score node on HUD
        scoreText.position = CGPoint(x: 70, y: 330)
        scoreCountText.position = CGPoint(x: 140, y: 340)
        scoreCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(scoreText)
        self.addChild(scoreCountText)
        
        // setting up lives node on HUD
        for index in 0..<3 {
            let newLifeNode = SKSpriteNode(texture: textureAtlas.textureNamed("star"))
            newLifeNode.size = CGSize(width: 50, height: 50)
            let xPos = CGFloat(50 * index + 10) + 25
            let yPos = screenSize.height - 70
            newLifeNode.position = CGPoint(x: xPos, y: yPos)
            lifeNodes.append(newLifeNode)
            self.addChild(newLifeNode)
        }
    }
    
    func updateScore(newScoreCount: Int) {
        let formatter = NumberFormatter()
        let number = NSNumber(value: newScoreCount)
        formatter.minimumIntegerDigits = 3
        if let scoreStr = formatter.string(from: number) {
            scoreCountText.text = scoreStr
        }
    }
    
    func updateLives(newLives: Int) {
        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: 0)
        for index in 0 ..< lifeNodes.count {
            if index < newLives {
                lifeNodes[index].alpha = 1
            }
            else {
                lifeNodes[index].run(fadeAction)
            }
        }
    }
}
