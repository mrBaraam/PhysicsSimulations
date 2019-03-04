//
//  ThermalTransferViewController.swift
//  group3_PhysicsApp
//
//  Created by Period Three on 2018-11-20.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import SpriteKit

class ThermalTransferViewController: UIViewController{

    override func viewDidLoad() {

        super.viewDidLoad()
        
        if let view = self.view as? SKView{

            if let scene = SKScene(fileNamed: "ThermalTransferScene")as? ThermalTransferScene{
                scene.scaleMode = .aspectFill
              
                view.presentScene(scene)
            }
        }
        
        
    }
    
    override var shouldAutorotate: Bool {
        return false
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
