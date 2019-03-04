//
//  GameViewController.swift
//  Electromagnetic Faraday
//
//  Created by Period Three on 2018-12-13.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MagnetGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MagnetGameScene") as? MagnetGameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
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
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
