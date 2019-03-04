//
//  carFrictionScene.swift
//  group3_PhysicsApp
//
//  Created by Steven Egerszegi on 2018-12-09.
//  Copyright © 2018 Period Three. All rights reserved.
//

import SpriteKit
import UIKit

var car1Displacement = -1.0
var car2Displacement = -1.0
var car1Accel = 1.0
var car2Accel = 1.0
var car1k = 0.0
var car2k = 0.0
var car1v = 0
var car2v = 0
var menuAccessed = false

class CarFrictionScene: SKScene {
    var viewController: CarFrictionViewController?
    
    var car1 = SKSpriteNode(imageNamed: "car")
    var car2 = SKSpriteNode(imageNamed: "car")
    var edit = SKSpriteNode(imageNamed: "button_editCar")
    var manu = SKSpriteNode(imageNamed: "button_manuCar")
    var road = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 0, height: 0))
    var roadLines: [SKSpriteNode] = []
    var cameraNode: SKCameraNode?
    var scrollAction = SKAction.moveBy(x: -160, y: 0, duration: 2)
    var loopAnchorX:CGFloat = 0.0
    var loopAction = SKAction.moveTo(x: 0, duration: 0)
    var testobject = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10, height: 720))
    var brakeButton = SKButtonNode(normalTexture: SKTexture(imageNamed: "button_brakeCar"), selectedTexture: SKTexture(imageNamed: "button_brakeCar"), disabledTexture: nil)
    //var brake = SKAction.applyForce(CGVector(dx: 0, dy: 0), duration: 0)
    var brake = SKAction.moveBy(x: 0, y: 0, duration: 0)
    var cameraShift = SKAction.moveBy(x: 0, y: 0, duration: 0)
    var testButton = SKButtonNode(normalTexture: SKTexture(imageNamed: "button"), selectedTexture: SKTexture(imageNamed: "button"), disabledTexture: nil)
    var disArrow1 = SKSpriteNode(color: UIColor.black, size: CGSize(width: 10, height: 10))
    var disArrow2 = SKSpriteNode(color: UIColor.black, size: CGSize(width: 10, height: 10))
    var grass = SKSpriteNode(color: UIColor.green, size: CGSize(width: 0, height: 0))
    var unitMuliplier:CGFloat = 0
    var testscale = 1
    var changeLoop = false
    var displacementLabelOne = SKLabelNode(text: "")
    var displacementLabelTwo = SKLabelNode(text: "")
    var braked = false
    var carsDisplaced = false

    
    override func didMove(to view: SKView) {
        car1.position = CGPoint(x: (frame.origin.x)/1.4, y: 0)
        car2.position = CGPoint(x: (frame.origin.x)/1.3, y: -100)
        car2.zPosition = 2
        edit.position = CGPoint(x: 1, y: -(frame.origin.y)/1.5) //(frame.maxX*(3/4))
        manu.position = CGPoint(x: 400, y: -(frame.origin.y)/1.5)
        print("EDIT")
        print(edit.position.x)
        edit.setScale(frame.origin.y/frame.origin.x)
        edit.name = "EDIT"
        edit.zPosition = 5
        
        manu.setScale(frame.origin.y/frame.origin.x)
        manu.name = "Manu"
        manu.zPosition = 5
        
        road.size = CGSize(width: 2*(frame.origin.x), height: 200)
        road.position = CGPoint(x: 0, y: ((car1.position.y+car2.position.y)/1.1))
        loopAnchorX = (frame.maxX)
        testobject.position = CGPoint(x: -640, y: 0)
        grass = SKSpriteNode(color: UIColor.brown , size: CGSize(width: (frame.maxX)*2, height: (frame.maxY)))
        grass.position.y = frame.origin.y/2
        grass.zPosition = -3
        addChild(road)
        addChild(car1)
        addChild(car2)
        addChild(edit)
        addChild(manu)
        //addChild(testButton)
        addChild(grass)
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        self.addChild(cameraNode!)
        let roadLCount = Int(abs(road.size.width/160))+1
        print(roadLCount)
        for i in 0..<roadLCount{
            let roadLine = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 80, height: 10))
            roadLine.position = CGPoint(x: CGFloat(frame.origin.x+CGFloat((160)*i)), y: ((car1.position.y+car2.position.y)/1.1))
            roadLine.zPosition = 1
            roadLines.append(roadLine)
            addChild(roadLine)
        }
        loopAction = SKAction.moveTo(x: loopAnchorX+(roadLines[0].size.width), duration: 0)
        brakeButton.position = CGPoint(x: 0, y: 0)
        brakeButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(CarFrictionScene.brakeBtnAction))
        testButton.position = CGPoint(x: 0, y: 200)
        testButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(CarFrictionScene.testActionbutton))
        
        unitMuliplier = 5
        //print(loopAnchorX)
        var testobject2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10, height: 720))
        testobject2.position = CGPoint(x: 640, y: 0)
        
    }

    
    @objc func testActionbutton(){
        brakeButton.removeFromParent()
        car1.removeFromParent()
        car2.removeFromParent()
        road.removeFromParent()
        displacementLabelOne.removeFromParent()
        displacementLabelTwo.removeFromParent()
        disArrow1.removeFromParent()
        disArrow2.removeFromParent()
        cameraNode?.setScale(1)
        car1Displacement = -1.0
        car2Displacement = -1.0
        car1Accel = 1.0
        car2Accel = 1.0
        car1.position = CGPoint(x: (frame.origin.x)/1.4, y: 0)
        car2.position = CGPoint(x: (frame.origin.x)/1.3, y: -100)
        car2.zPosition = 2
        edit.position = CGPoint(x: 1, y: -(frame.origin.y)/1.5)
        edit.setScale(frame.origin.y/frame.origin.x)
        
        manu.position = CGPoint(x: 400, y: -(frame.origin.y)/1.5)
        manu.setScale(frame.origin.y/frame.origin.x)
        road.size = CGSize(width: 2*(frame.origin.x), height: 200)
        road.position = CGPoint(x: 0, y: ((car1.position.y+car2.position.y)/1.1))
        testobject.position = CGPoint(x: -640, y: 0)
        grass = SKSpriteNode(color: UIColor.brown , size: CGSize(width: (frame.maxX)*2, height: (frame.maxY)))
        grass.position.y = frame.origin.y/2
        grass.zPosition = -3
        cameraNode?.position = CGPoint(x: 0, y: 0)
        displacementLabelOne = SKLabelNode(text: "")
        displacementLabelTwo = SKLabelNode(text: "")
        loopAction = SKAction.moveTo(x: loopAnchorX+(roadLines[0].size.width), duration: 0)
        for i in 0..<roadLines.count{
            roadLines[i].removeFromParent()
        }
        let roadLCount = Int(abs(road.size.width/160))+1
        print(roadLCount)
        for i in 0..<roadLCount{
            let roadLine = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 80, height: 10))
            roadLine.position = CGPoint(x: CGFloat(frame.origin.x+CGFloat((160)*i)), y: ((car1.position.y+car2.position.y)/1.1))
            roadLine.zPosition = 1
            roadLines.append(roadLine)
            addChild(roadLine)
        }
        menuAccessed = false
        braked = false
        addChild(road)
        addChild(car1)
        addChild(car2)
    }
    
    override func update(_ currentTime: TimeInterval) {
        print(menuAccessed)
        if menuAccessed{
            addChild(brakeButton)
            menuAccessed = false
        }
        
        if changeLoop{
            loopAction = SKAction.moveTo(x: (road.size.width)+(roadLines[0].size.width), duration: 0)
            changeLoop = false
        }else{
           
            
        }
        
        for i in 0..<roadLines.count{
            if (Double(roadLines[i].position.x)) < Double(frame.origin.x)-Double(roadLines[0].size.width){
                roadLines[i].run(loopAction)
            }
        }
        if !braked{
            for i in 0..<roadLines.count{
                roadLines[i].run(SKAction.moveBy(x: -20, y: 0, duration: 0))
            }
        }
        
    }
    
    @objc func roadArrange1(){
        for i in 0..<roadLines.count{
            self.roadLines[i].run(scrollAction)
        }
    }
    
    @objc func roadArrange(){
        perform(#selector(roadArrange1), with: nil, afterDelay: 2)
    }
    
    @objc func brakeBtnAction(){
        //brake = SKAction.applyForce(CGVector(dx: 100, dy: 0), duration: 10)
        //brake = SKAction.move(by: CGVector(dx: <#T##Double#>, dy: 0), duration: 10)
        print(car1Displacement*Double(unitMuliplier))
        print(car2Displacement*Double(unitMuliplier))
        braked = true

        disArrow1.position = CGPoint(x: frame.origin.x-car1.position.x, y: 700)
        disArrow2.position = CGPoint(x: frame.origin.x-car2.position.x, y: -700)
        
        var oldMes1 = disArrow1.position.x
        var oldMes2 = disArrow2.position.x

        if car1Displacement > car2Displacement{
            
            let frameTW = (-2*(frame.origin.x))
            let scaleNew = (((CGFloat(car1Displacement)*CGFloat(unitMuliplier*1.25)))+(frame.origin.x-car1.position.x))/frameTW
            if CGFloat(car1Displacement*Double(unitMuliplier)) > frameTW{
                road.removeFromParent()
                road = SKSpriteNode(color: UIColor.gray, size: CGSize(width: ((car1Displacement*Double(unitMuliplier*1.25))-Double(frame.origin.x-car1.position.x)), height: 200))
                road.position = CGPoint(x: 0, y: ((car1.position.y+car2.position.y)/1.1))
                road.zPosition = -1
                addChild(road)
                cameraNode?.setScale(scaleNew)
                let cameraDisplacement = ((car1Displacement*Double(unitMuliplier*1.25))+Double(frame.origin.x-car1.position.x)*8)/2
                cameraShift = SKAction.moveBy(x: CGFloat(cameraDisplacement), y: 0, duration: 0)
                cameraNode?.run(cameraShift)
                road.run(cameraShift)
                let fontSize1 = displacementLabelOne.fontSize*scaleNew
                let fontSize2 = displacementLabelTwo.fontSize*scaleNew
                displacementLabelOne.fontSize = fontSize1
                displacementLabelTwo.fontSize = fontSize2
                grass.removeFromParent()
                grass = SKSpriteNode(color: UIColor.brown, size: CGSize(width: road.size.width, height: road.size.width))
                grass.position.y = -(road.size.width)/2
                grass.zPosition = -3
                addChild(grass)
                grass.run(cameraShift)
                edit.setScale(scaleNew*frame.origin.y/frame.origin.x)
                
                edit.run(SKAction.moveBy(x: (CGFloat(car1Displacement)*unitMuliplier/2), y: (edit.position.y*scaleNew)/2, duration: 0)) //(-frame.origin.x*scaleNew)/2
                manu.setScale((scaleNew*frame.origin.y/frame.origin.x))
               
            }else{
                
            }
        }else if car1Displacement < car2Displacement{
            print("test7865")
            let frameTW = (-2*(frame.origin.x))
            let scaleNew = (((CGFloat(car2Displacement)*CGFloat(unitMuliplier*1.25)))+(frame.origin.x-car1.position.x))/frameTW
            if CGFloat(car2Displacement*Double(unitMuliplier)) > frameTW{
                road.removeFromParent()
                road = SKSpriteNode(color: UIColor.gray, size: CGSize(width: ((car2Displacement*Double(unitMuliplier*1.25))+Double(frame.origin.x-car1.position.x)), height: 200))
                road.position = CGPoint(x: 0, y: ((car1.position.y+car2.position.y)/1.1))
                road.zPosition = -1
                addChild(road)
                cameraNode?.setScale(scaleNew)
                let cameraDisplacement = ((car2Displacement*Double(unitMuliplier*1.25))+Double(frame.origin.x-car1.position.x)*8)/2
                cameraShift = SKAction.moveBy(x: CGFloat(cameraDisplacement), y: 0, duration: 0)
                cameraNode?.run(cameraShift)
                road.run(cameraShift)
                let fontSize1 = displacementLabelOne.fontSize*scaleNew
                let fontSize2 = displacementLabelTwo.fontSize*scaleNew
                displacementLabelOne.fontSize = fontSize1
                displacementLabelTwo.fontSize = fontSize2
                
                grass.removeFromParent()
                grass = SKSpriteNode(color: UIColor.brown, size: CGSize(width: road.size.width, height: road.size.width))
                grass.position.y = -(road.size.width)/2
                grass.zPosition = -3
                addChild(grass)
                grass.run(cameraShift)
                edit.setScale(scaleNew*frame.origin.y/frame.origin.x)
                edit.run(SKAction.moveBy(x: (-frame.origin.x*scaleNew)/2, y: (edit.position.y*scaleNew)/2, duration: 0))
                
                manu.setScale(scaleNew*frame.origin.y/frame.origin.x)
               
                

            }else{
                
            }
        }

        brake = SKAction.moveBy(x: CGFloat(car1Displacement*Double(unitMuliplier)), y: 0, duration: 2.8)
        car1.run(brake)
        brake = SKAction.moveBy(x: CGFloat(car2Displacement*Double(unitMuliplier)), y: 0, duration: 2.8)
        car2.run(brake)
        for i in 0..<roadLines.count{
            roadLines[i].removeFromParent()
        }
        let roadLCount = Int(abs(road.size.width/160))
        print(roadLCount)
        for i in 0..<roadLCount{
            let roadLine = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 80, height: 10))
            roadLine.position = CGPoint(x: CGFloat(frame.origin.x+CGFloat((160)*i)), y: ((car1.position.y+car2.position.y)/1.1))
            roadLine.zPosition = 1
            roadLines.append(roadLine)
            addChild(roadLine)
        }
        changeLoop = true
        disArrow1.zPosition = 3
        disArrow2.zPosition = 3
        print(road.position.x)
        print(grass.position.x)
        disArrow1 = SKSpriteNode(color: UIColor.black, size: CGSize(width: CGFloat(car1Displacement)*unitMuliplier, height: 10))
        disArrow2 = SKSpriteNode(color: UIColor.black, size: CGSize(width: CGFloat(car2Displacement)*unitMuliplier, height: 10))
        disArrow1.position = CGPoint(x: (((disArrow1.size.width)/2)+frame.origin.x)-(oldMes1), y: 100)
        disArrow2.position = CGPoint(x: (((disArrow2.size.width)/2)+frame.origin.x)-(oldMes2), y: -300)
        displacementLabelOne.text = String(car1Displacement)
        displacementLabelOne.position.x = disArrow1.position.x
        displacementLabelOne.position.y = disArrow1.position.y+10
        displacementLabelTwo.text = String(car2Displacement)
        displacementLabelTwo.position.x = disArrow2.position.x
        displacementLabelTwo.position.y = disArrow2.position.y-10-(displacementLabelTwo.frame.height)
        displacementLabelOne.fontColor = UIColor.black
        displacementLabelTwo.fontColor = UIColor.black
        displacementLabelOne.text = "d = \(car1Displacement) m, µ = \(car1k), v = \(car1v) m/s"
        displacementLabelTwo.text = "d = \(car2Displacement) m, µ = \(car2k), v = \(car2v) m/s"
        displacementLabelOne.fontName = "HelveticaBold"
        displacementLabelTwo.fontName = "HelveticaBold"
        addChild(disArrow1)
        addChild(disArrow2)
        addChild(displacementLabelOne)
        addChild(displacementLabelTwo)
        brakeButton.removeFromParent()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            for i in 0..<roadLines.count{
               // roadLines[i].run(scrollAction)
            }
            
            if node?.name == "EDIT" {
               self.view?.window?.rootViewController?.performSegue(withIdentifier: "carEdit", sender: nil)
                testActionbutton()
            }
            if node?.name == "Manu" {
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
               testActionbutton()
            }

        }
    }
    
    
    
}
