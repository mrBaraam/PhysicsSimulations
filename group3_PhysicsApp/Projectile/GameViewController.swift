//
//  GameViewController.swift
//  ProjectileMotionSK
//
//  Created by Period Three on 2018-11-22.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("view did load load the scene")
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScene"){
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
               // scene.projectileViewController = self
                // Present the scene
                view.presentScene(scene)
                
                print("game view controller")
            }
           
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }
    
    
    @IBAction func unwindToPhysicsManu(segue: UIStoryboardSegue) {

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
