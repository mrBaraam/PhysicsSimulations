//
//  carFrictionViewController.swift
//  group3_PhysicsApp
//
//  Created by Steven Egerszegi on 2018-12-09.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import SpriteKit

class CarFrictionViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? SKView{
            if let scene = SKScene(fileNamed: "CarFrictionScene")as? CarFrictionScene{
                scene.scaleMode = .aspectFit
                //scene.xScale = view.frame.minX
                //scene.yScale = view.frame.maxY/2
                scene.viewController = self
                view.presentScene(scene)
               // print(view.frame.maxX)
               // print(view.frame.maxY/2)
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
