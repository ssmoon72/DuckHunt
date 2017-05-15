//
//  MainMenu.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        AudioManager.instance.playMainMenuMusic()
        
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self);
            
            if nodes(at: location)[0].name == "Start" {
                let scene = GameScene(fileNamed: "GameScene");
                self.view?.presentScene(scene!, transition:SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
        }
    }
}
