//
//  GameViewController.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let view = self.view as! SKView? {
            //Load the SKScene from 'GameScene.sks'
            if let scene = MainMenuScene(fileNamed: "MainMenu") {
                // Set the scale mode fit the window
                scene.scaleMode = .aspectFill
                // Size our scene to fit the view exactly:
                scene.size = view.bounds.size
                // Show the new scene:
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
