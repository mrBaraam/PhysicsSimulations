//
//  GameScene.swift
//  Friction
//
//  Created by Home on 2018-11-29.
//  Copyright © 2018 Home. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
class FrictionGameScene: SKScene, SKPhysicsContactDelegate {
    var viewController: FrictionGameViewController?
    var car = SKSpriteNode()
    var table = SKSpriteNode()
    var block = SKSpriteNode()
    var stringOne = SKSpriteNode()
    var stringTwo = SKSpriteNode()
    var pulley = SKSpriteNode()
    var speed1: Double = 0.0
    var showDuration: Double = 0.0
    var time = 0
    let tableCategory:UInt32 = 0x1 << 0
    let carCategory:UInt32 = 0x1 << 1
    let blockCategory:UInt32 = 0x1 << 2
    let pulleyCategory:UInt32 = 0x1 << 3
     let accelerationLabel = SKLabelNode(fontNamed: "Chalkduster")
    let editLabel = SKLabelNode(fontNamed: "Chalkduster")
    let startLabel = SKLabelNode(fontNamed: "Chalkduster")
    let tentionLabel = SKLabelNode(fontNamed: "Chalkduster")
    let frictionLabel = SKLabelNode(fontNamed: "Chalkduster")
    let speedLabel = SKLabelNode(fontNamed: "Chalkduster")
    let timeLabel = SKLabelNode(fontNamed: "Chalkduster")
    let setLabel1 = SKLabelNode(fontNamed: "Chalkduster")
    let distanceLabel = SKLabelNode(fontNamed: "Chalkduster")
    let normalForceLabel = SKLabelNode(fontNamed: "Chalkduster")
    let backToManuLabel = SKLabelNode(fontNamed: "Chalkduster")
    var countingTime: Double = 0.0
    
    var timer = Timer()
    
    @objc func action1() {
        countingTime += 1
        speed1 = acceleration*countingTime
    }
    
    func creatLabel() {
        //Acceleration Label
        accelerationLabel.position = CGPoint(x: 180, y: 166)
        accelerationLabel.fontSize = 24
        accelerationLabel.text = "Acceleration: \(acceleration) m/s²"
        addChild(accelerationLabel)
        
        //Tention Label
        tentionLabel.position = CGPoint(x: 180, y: 196)
        tentionLabel.fontSize = 24
        tentionLabel.text = "Tention: \(globalTention) N"
        addChild(tentionLabel)
        
        //Friction Label
        frictionLabel.position = CGPoint(x: 180, y: 136)
        frictionLabel.fontSize = 24
        frictionLabel.text = "Friction: \(globalFriction) N"
        addChild(frictionLabel)
        
        //Edit Label
        editLabel.name = "Edit"
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 560, y: 86)
        editLabel.fontSize = 36
        addChild(editLabel)
        //Back To Manu Label
        backToManuLabel.name = "Manu"
        backToManuLabel.text = "Manu"
        backToManuLabel.position = CGPoint(x: 560, y: 46)
        backToManuLabel.fontSize = 36
        addChild(backToManuLabel)
        
        
        
        
        //Start Label
        startLabel.name = "Start"
        startLabel.text = "Start"
        startLabel.position = CGPoint(x: 560, y: 230)
        startLabel.fontSize = 56
        addChild(startLabel)
        
        //Speed Label
        speedLabel.position = CGPoint(x: 180, y: 46)
        speedLabel.fontSize = 24
        speedLabel.text = "Speed: \(speed1) m/s"
        addChild(speedLabel)
        
        //Time Label
        timeLabel.position = CGPoint(x: 180, y: 76)
        timeLabel.text = "Time: \(countingTime) s"
        timeLabel.fontSize = 24
        addChild(timeLabel)
        
        //Set Label
        setLabel1.name = "Set"
        setLabel1.text = "Set"
        setLabel1.position = CGPoint(x: 560, y: 126)
        setLabel1.fontSize = 36
        addChild(setLabel1)
        
        //Distance Label
        let distance = (320/14)*10
        distanceLabel.text = "Distance: \(distance) m"
        distanceLabel.position = CGPoint(x: 560, y: 320)
        distanceLabel.fontSize = 24
        addChild(distanceLabel)
        
        //Normal Force
        normalForceLabel.text = "Normal Force: \(normalForce) N"
        normalForceLabel.position = CGPoint(x: 180, y: 106)
        normalForceLabel.fontSize = 24
        addChild(normalForceLabel)
    }
    
    func recreatePhysicsBody() {
        //Recreate car physicsBody
        car.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: car.size.width, height: car.size.height/3))
        car.physicsBody?.affectedByGravity = false
        car.physicsBody?.friction = 0
        car.physicsBody?.categoryBitMask = carCategory
        
        //Recreate block physicsBody
       
        block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: block.size.width, height: block.size.height))
        block.physicsBody?.affectedByGravity = false
        
        //Recreate pulley physicsBody
        pulley.physicsBody = SKPhysicsBody(circleOfRadius: pulley.size.width/2)
        pulley.physicsBody?.affectedByGravity = false
    
        pulley.physicsBody?.categoryBitMask = pulleyCategory
        pulley.physicsBody?.contactTestBitMask = carCategory
        
    }
    
    
    
    
    
    
    override func didMove(to view: SKView) {
         self.physicsWorld.contactDelegate = self
    
        creatLabel()
        
        if globalFriction == 0.0 {
            startLabel.isHidden = true
        }

        if let theTable = self.childNode(withName: "tableImg") as? SKSpriteNode {
            table = theTable
            table.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: table.size.width, height: table.size.height))
            table.physicsBody?.isDynamic = false
            table.physicsBody?.categoryBitMask = tableCategory
        }
        
        if let theFirstBlock = self.childNode(withName: "carImg") as? SKSpriteNode {
            car = theFirstBlock
          car.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: car.size.width, height: car.size.height/3))
            car.physicsBody?.affectedByGravity = false
            car.physicsBody?.friction = 0
           car.physicsBody?.categoryBitMask = carCategory
        }
        car.physicsBody?.collisionBitMask = pulleyCategory
        
        if let theBlock = self.childNode(withName: "blockImg") as? SKSpriteNode {
            block = theBlock
            block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: block.size.width, height: block.size.height))
            block.physicsBody?.affectedByGravity = false
           
            
        }
        if let theString1 = self.childNode(withName: "0") as? SKSpriteNode {
            stringOne = theString1
        
        }
        if let theString2 = self.childNode(withName: "1") as? SKSpriteNode {
            stringTwo = theString2
        }
        if let thePulley = self.childNode(withName: "pulleyImg") as? SKSpriteNode {
            pulley = thePulley
            pulley.physicsBody = SKPhysicsBody(circleOfRadius: pulley.size.width/2)
            pulley.physicsBody?.affectedByGravity = false
        }
        pulley.physicsBody?.categoryBitMask = pulleyCategory
        pulley.physicsBody?.contactTestBitMask = carCategory
         accelerationLabel.text = "Acceleration: \(acceleration)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            if node?.name == "Edit" {
              
            car.position = CGPoint(x: 46.999, y: 339.069)
            block.position = CGPoint(x: 431.014, y: 294.828)
                block.physicsBody = nil
                block.removeAllActions()
                car.removeAllActions()
                
               globalTention = 0.0
               globalFriction = 0.0
                speed1 = 0
                acceleration = 0
                countingTime = 0
                showDuration = 0
                startLabel.isHidden = true
                normalForce = 0
                setLabel()
                timer.invalidate()
                
           // var frictionVc = UIStoryboard(name: "GameViewController", bundle: nil)
           // var vc = frictionVc.instantiateViewController(withIdentifier: "FrictionEditor") as! UIViewController
            //   self.view!.window!.rootViewController!.present(vc, animated: true, completion: nil)
        self.view!.window?.rootViewController?.performSegue(withIdentifier: "segue", sender: nil)
       // self.viewController?.performSegue(withIdentifier: "segue", sender: nil)
     
            } else if node?.name == "Start" {
                recreatePhysicsBody()
                let distance = (320/14)*10
                let duration = sqrt(Double((2*distance))/(acceleration))
                showDuration = (duration*1000).rounded() / 1000
                car.physicsBody?.friction = 0
                
                let moveAction = SKAction.applyForce(CGVector(dx: globalTotal, dy: 0), duration: 100)
                
                car.run(moveAction)
                
                let rotateAction = SKAction.rotate(byAngle: -360, duration: 100)
                pulley.run(rotateAction)
                
                let blockAction = SKAction.applyForce(CGVector(dx: 0, dy: -globalTotal/3), duration: 100)
                block.run(blockAction)
                setLabel()
                print("globaltotal: \(globalTotal)")
                
            } else if node?.name == "Set"{
                if globalFriction != 0 {
                    
                startLabel.isHidden = false
                    setLabel()
                }
            } else if node?.name == "Manu"{
                globalTention = 0.0
                globalFriction = 0.0
                speed1 = 0
                acceleration = 0
                countingTime = 0
                showDuration = 0
                startLabel.isHidden = true
                normalForce = 0
                setLabel()
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
        }
      
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == carCategory | pulleyCategory {
           
            car.physicsBody?.collisionBitMask = pulleyCategory
            pulley.physicsBody = nil
            car.physicsBody = nil
            block.physicsBody = nil
            pulley.removeAllActions()
            stringTwo.removeAllActions()
            block.removeAllActions()
            print("collision")
            
        }
    }
    
    func setLabel() {
        accelerationLabel.text = "Acceleration: \((acceleration*1000).rounded()/1000) m/s²"
        tentionLabel.text = "Tention: \((globalTention*1000).rounded()/1000) N"
        frictionLabel.text = "Friction: \((globalFriction*1000).rounded()/1000) N"
        normalForceLabel.text = "Normal Force: \(normalForce) N"
        
        if acceleration == 0 {
            speedLabel.text = "Final Speed: 0 m/s"
            timeLabel.text = "Total Time: 0 s"
        } else  {
        speedLabel.text = "Final Speed: \((showDuration*acceleration*1000).rounded()/1000) m/s"
        timeLabel.text = "Total Time: \(showDuration) s"
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        distanceOne = Double(pulley.position.x - car.position.x)
        distanceTwo = Double(pulley.position.y - block.position.y)
        stringOne.size.width = CGFloat(distanceOne)
        stringTwo.size.height = CGFloat(distanceTwo)
        
      
    }
}
