//
//  GameOver.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var score = 0
    let scoreLabel = SKLabelNode(fontNamed: "ArialMT")
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        
        scoreLabel.text = String(self.score)
        scoreLabel.position = CGPoint(x: 400, y: 170)
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 8
        self.addChild(scoreLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self);
            
            if nodes(at: location)[0].name == "Restart" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                self.view?.presentScene(scene!, transition:SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
        }
    }
}
