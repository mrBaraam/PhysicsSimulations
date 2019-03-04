//
//  MenuScene.swift
//  group3_PhysicsApp
//
//  Created by Yuying Li on 2019-01-15.
//  Copyright © 2019 Period Three. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MenuScene: SKScene {

    var thermalEnergyLabel = SKLabelNode(text: "Thermal Energy")
    var kineticEnergyLabel = SKLabelNode(text: "Kinetic Energy")
    var staticFrictionLabel = SKLabelNode(text: "Static and Kinetic Friction")
    var magnetLabel = SKLabelNode(text: "Electricty, Magnet & Circuits")
    var projectileLabel = SKLabelNode(text: "Projectile Motion")
    
    
    override func didMove(to view: SKView) {
        thermalEnergyLabel.fontSize = 36
        thermalEnergyLabel.position = CGPoint(x: 0, y: 130)
        thermalEnergyLabel.name = "thermalEnergy"
        thermalEnergyLabel.fontName = "Chalkduster"
        addChild(thermalEnergyLabel)
        
       kineticEnergyLabel.fontSize = 36
       kineticEnergyLabel.position = CGPoint(x: 0, y: 60)
       kineticEnergyLabel.name = "kineticEnergy"
       kineticEnergyLabel.fontName = "Chalkduster"
        addChild(kineticEnergyLabel)
        
        staticFrictionLabel.fontSize = 36
        staticFrictionLabel.position = CGPoint(x: 0, y: -10)
        staticFrictionLabel.name = "staticFriction"
        staticFrictionLabel.fontName = "Chalkduster"
        addChild(staticFrictionLabel)
        
        magnetLabel.fontSize = 36
        magnetLabel.position = CGPoint(x: 0, y: -70)
        magnetLabel.name = "magnet"
        magnetLabel.fontName = "Chalkduster"
        addChild(magnetLabel)
        
        projectileLabel.fontSize = 36
        projectileLabel.position = CGPoint(x: 0, y: -130)
         projectileLabel.name = "projectileMotion"
        projectileLabel.fontName = "Chalkduster"
        addChild(projectileLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            if node?.name == "staticFriction" {
                if let view = self.view as? SKView {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "FrictionGameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                      
                        // Present the scene
                        
                        view.presentScene(scene)
                    }
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            } else if node?.name == "thermalEnergy" {
                
                if let view = self.view as? SKView{
                    
                    if let scene = SKScene(fileNamed: "ThermalTransferScene") as? ThermalTransferScene{
                        scene.scaleMode = .aspectFill
                       
                        
                        if elementTT == "water"{
                            print("water")
                            scene.cube.texture = SKTexture(imageNamed: "ice_cube")
                            if tagTT == 1 {
                                scene.cube.texture = SKTexture(imageNamed: "ice_cube_melt_2_3")
                                scene.thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0))
                                scene.thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0))
                            }else if tagTT == 2{
                                scene.cube.texture = SKTexture(imageNamed: "ice_cube_melt_3_3")
                                scene.thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                                scene.thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                            }else if tagTT == 3{
                                scene.cube.texture = SKTexture(imageNamed: "water")
                                scene.thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                                scene.thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                            }
                            print()
                        }else if elementTT == "aluminum"{
                            scene.cube.texture = SKTexture(imageNamed: "iron_block")
                            if tagTT == 1 {
                                scene.cube.texture = SKTexture(imageNamed: "iron_block_2_3")
                                scene.thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0))
                                scene.thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0))
                            }else if tagTT == 2{
                                scene.cube.texture = SKTexture(imageNamed: "iron_block_3_3")
                                scene.thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                                scene.thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                            }else if tagTT == 3{
                                scene.cube.texture = SKTexture(imageNamed: "iron_molten")
                                scene.thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                                scene.thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                            }
                        }
                        
                        
                        scene.button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.calAction))
                        
                        scene.toChartButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.goToChart))
                        
                        scene.editButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.edit))
                        //temperatures.append(initialTT)
                        times.append(0)
                        view.presentScene(scene)
                    }
                }
            } else if node?.name == "kineticEnergy" {
                if let view = self.view as? SKView{
                    if let scene = SKScene(fileNamed: "CarFrictionScene"){
                        scene.scaleMode = .aspectFit
                        //scene.xScale = view.frame.minX
                        //scene.yScale = view.frame.maxY/2
                       
                        view.presentScene(scene)
                        // print(view.frame.maxX)
                        // print(view.frame.maxY/2)
                    }
                }
            } else if node?.name == "magnet" {
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "MagnetGameScene")  {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFit
                        // Present the scene
                        view.presentScene(scene)
                    }
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            } else if node?.name == "projectileMotion" {
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene"){
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
            
            
            
            
        }
    }
    
}
