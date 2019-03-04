//
//  ThermalTransferScene.swift
//  group3_PhysicsApp
//
//  Created by Period Three on 2018-11-20.
//  Copyright © 2018 Period Three. All rights reserved.
//

import SpriteKit
import UIKit
import Charts

var temperatures: [Double] = []
var times: [Double] = []

class ThermalTransferScene: SKScene {
    var firstUse: Bool = true
    var cube = SKSpriteNode(color: UIColor.white, size: CGSize(width: 200, height: 200))
    var candle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 50, height: 200))
    var equation = SKLabelNode(text: "Equation")
    var energy = SKLabelNode(text: "Energy")
    var menu = SKLabelNode(text: "Menu")

    var state = SKLabelNode(text: "")
    var fire = SKEmitterNode(fileNamed: "candleLight")
     var thermometer =  SKShapeNode()
    var actionReady: Bool = false
    var toChartButton = SKButtonNode(normalTexture: SKTexture(imageNamed: "button_go-to-chart"), selectedTexture:SKTexture(imageNamed: "button_go-to-chart"), disabledTexture: nil)
    var button = SKButtonNode(normalTexture: SKTexture(imageNamed: "button_advance-time"), selectedTexture: SKTexture(imageNamed: "button_advance-time"), disabledTexture: nil)
     //need to add collision bitmasks; disabled texture needed
    var editButton = SKButtonNode(normalTexture: SKTexture(imageNamed: "button_edit"), selectedTexture: SKTexture(imageNamed: "button_edit"), disabledTexture: nil)
     
    var currentObject = ""
    var timeMain: Double = 0
     var viewController: ThermalTransferViewController?
     var testButton = SKButtonNode(normalTexture:  SKTexture(imageNamed: "button_advance-time"), selectedTexture:  SKTexture(imageNamed: "button_advance-time"), disabledTexture: nil)
     var thermometerRed = SKSpriteNode()
     let setLabel1 = SKLabelNode(fontNamed: "Chalkduster")
     
    override func didMove(to view: SKView) {
     scene?.backgroundColor = UIColor.black
    // equation.color = UIColor.black
    // energy.color = UIColor.black
     //state.color = UIColor.black
     setLabel1.name = "Set"
     setLabel1.text = "Set"
     setLabel1.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -20)
     setLabel1.fontSize = 36
     addChild(setLabel1)
     
     print("did move did move")
     energy.fontName = "HelveticaBold"
     equation.fontName = "HelveticaBold"
     state.fontName = "HelveticaBold"
     cube.position = CGPoint(x: 0, y: 0)
     equation.position = CGPoint(x: 0, y: (frame.origin.y-(frame.origin.x*2.15)))
     energy.position = CGPoint(x: 0, y: (frame.origin.y-(frame.origin.x*2.1)))
     state.position = CGPoint(x: 0, y: (frame.origin.y-(frame.origin.x*2.20)))
     candle.position = CGPoint(x: -frame.origin.x/2, y: frame.origin.y/6)
     fire?.position = CGPoint(x: -(frame.origin.x/2), y: frame.origin.y/6+((frame.origin.x/frame.origin.y)*100))
     menu.name = "menu"
     menu.fontName = "Chalkduster"
     menu.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -50)
     editButton.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -150)
     button.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -100)
     toChartButton.position = CGPoint(x: -(frame.origin.x/1.2), y: 0)
     cube.setScale(frame.origin.x/frame.origin.y)
     candle.setScale(frame.origin.x/frame.origin.y)
     equation.setScale(frame.origin.x/frame.origin.y)
     energy.setScale(frame.origin.x/frame.origin.y)
     state.setScale(frame.origin.x/frame.origin.y)
     fire?.setScale(frame.origin.x/frame.origin.y)
     toChartButton.setScale(frame.origin.x/frame.origin.y)
     button.setScale(frame.origin.x/frame.origin.y)
     editButton.setScale(frame.origin.x/frame.origin.y)
     print(frame.origin.y)
        cube.name = "CUBE"
        equation.name = "EQUATION"
        energy.name = "ENERGY"
        state.name = "NAME"
        candle.name = "CANDLE"
        editButton.name = "Edit"
        menu.fontSize = 24
     addChild(menu)
     addChild(thermometerRed)
        addChild(cube)
        addChild(equation)
        addChild(energy)
        addChild(state)
        addChild(candle)
        addChild(button)
        addChild(fire!)
        addChild(thermometer)
        addChild(toChartButton)
        addChild(editButton)
       // tagTT += 1
        if elementTT == "water"{
            print("water")
            cube.texture = SKTexture(imageNamed: "ice_cube")
          if tagTT == 1 {
               cube.texture = SKTexture(imageNamed: "ice_cube_melt_2_3")
               thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0))
               thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0))
          }else if tagTT == 2{
               cube.texture = SKTexture(imageNamed: "ice_cube_melt_3_3")
               thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
               thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
          }else if tagTT == 3{
               cube.texture = SKTexture(imageNamed: "water")
               thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
               thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
          }
            print()
        }else if elementTT == "aluminum"{
          cube.texture = SKTexture(imageNamed: "iron_block")
          if tagTT == 1 {
               cube.texture = SKTexture(imageNamed: "iron_block_2_3")
               thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0))
               thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0))
          }else if tagTT == 2{
               cube.texture = SKTexture(imageNamed: "iron_block_3_3")
               thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
               thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
          }else if tagTT == 3{
               cube.texture = SKTexture(imageNamed: "iron_molten")
               thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
               thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
          }
     }
     
     
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.calAction))
        
        toChartButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.goToChart))
     
         editButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.edit))
     //temperatures.append(initialTT)
     
    }
     
    
     
    @objc func calAction(){

     print("Action Paacked")
     calculateFunction(initial: initialTT, power: powerTT, mass: massTT)
     tagTT += 1
    }
     
    
    @objc func goToChart(){
          self.view?.window?.rootViewController?.performSegue(withIdentifier: "goChart", sender: nil)
    }
    
     @objc func edit() {
          tagTT = 0
          thermometerRed.removeAllActions()
          self.view?.window?.rootViewController?.performSegue(withIdentifier: "thermalEdit", sender: nil)
     }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
     
            if node?.name == "CUBE"{
                currentObject = "CUBE"
            }
            if node?.name == "CANDLE" {
                currentObject = "CANDLE"
               
            }
          if node?.name == "menu" {
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
          if node?.name == "Set" {
               scene?.backgroundColor = UIColor.black
               tagTT = 0
               energy.text = ""
               equation.text = ""
               state.text = ""
               
               setLabel1.name = "Set"
               setLabel1.text = "Set"
               setLabel1.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -30)
               setLabel1.fontSize = 36
               print("did move did move")
               energy.fontName = "HelveticaBold"
               equation.fontName = "HelveticaBold"
               state.fontName = "HelveticaBold"
               cube.position = CGPoint(x: 0, y: 0)
               equation.position = CGPoint(x: 0, y: (frame.origin.y-(frame.origin.x*2.15)))
               energy.position = CGPoint(x: 0, y: (frame.origin.y-(frame.origin.x*2.1)))
               state.position = CGPoint(x: 0, y: (frame.origin.y-(frame.origin.x*2.20)))
               candle.position = CGPoint(x: -frame.origin.x/2, y: frame.origin.y/6)
               fire?.position = CGPoint(x: -(frame.origin.x/2), y: frame.origin.y/6+((frame.origin.x/frame.origin.y)*100))
               menu.name = "menu"
               menu.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -50)
               editButton.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -150)
               button.position = CGPoint(x: frame.origin.x-(frame.origin.x/3), y: -100)
               toChartButton.position = CGPoint(x: -(frame.origin.x/1.2), y: 0)
               cube.setScale(frame.origin.x/frame.origin.y)
               candle.setScale(frame.origin.x/frame.origin.y)
               equation.setScale(frame.origin.x/frame.origin.y)
               energy.setScale(frame.origin.x/frame.origin.y)
               state.setScale(frame.origin.x/frame.origin.y)
               fire?.setScale(frame.origin.x/frame.origin.y)
               toChartButton.setScale(frame.origin.x/frame.origin.y)
               button.setScale(frame.origin.x/frame.origin.y)
               editButton.setScale(frame.origin.x/frame.origin.y)
               thermometer.setScale(frame.origin.x/frame.origin.y)
               thermometerRed.setScale(frame.origin.x/frame.origin.y)
               thermometerRed = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 1))
               thermometer = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 20, height: 200))
               thermometer.position = CGPoint(x: (frame.origin.x/1.2)-(20/2), y: 0)
               thermometerRed.position = CGPoint(x: (frame.origin.x/1.2), y: 0)
               print(thermometer.position.y)
               print(frame.origin.y)
               
               cube.name = "CUBE"
               equation.name = "EQUATION"
               energy.name = "ENERGY"
               state.name = "NAME"
               candle.name = "CANDLE"
               editButton.name = "Edit"
               menu.fontSize = 24
               if elementTT == "water"{
                    print("water")
                    cube.texture = SKTexture(imageNamed: "ice_cube")
                    if tagTT == 1 {
                         cube.texture = SKTexture(imageNamed: "ice_cube_melt_2_3")
                         thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0))
                         thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0))
                    }else if tagTT == 2{
                         cube.texture = SKTexture(imageNamed: "ice_cube_melt_3_3")
                         thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                         thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                    }else if tagTT == 3{
                         cube.texture = SKTexture(imageNamed: "water")
                         thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                         thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                    }
                    print()
               }else if elementTT == "aluminum"{
                    cube.texture = SKTexture(imageNamed: "iron_block")
                    if tagTT == 1 {
                         cube.texture = SKTexture(imageNamed: "iron_block_2_3")
                         thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0))
                         thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0))
                    }else if tagTT == 2{
                         cube.texture = SKTexture(imageNamed: "iron_block_3_3")
                         thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                         thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                    }else if tagTT == 3{
                         cube.texture = SKTexture(imageNamed: "iron_molten")
                         thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0))
                         thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0))
                    }
               }
               addChild(thermometer)
               addChild(thermometerRed)
               button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.calAction))
               
               toChartButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.goToChart))
               
               editButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ThermalTransferScene.edit))
               //temperatures.append(initialTT)
               
               
          }
          
     }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentObject == "CUBE"{
                cube.position = location
            }
            if currentObject == "CANDLE"{
                candle.position = location
                fire?.position.x = location.x
                fire?.position.y = (location.y)+((frame.origin.x/frame.origin.y)*100)
            }
        }
        
 
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
          
            if currentObject == "CUBE"{
                cube.position = location
                currentObject = ""
            }
            
            if currentObject == "CANDLE"{
                candle.position = location
                fire?.position.x = location.x
                fire?.position.y = (location.y)+((frame.origin.x/frame.origin.y)*100)
                currentObject = ""
            }
            
            if node?.name == "CANDLE" {
                print("CanadLElo")
            }
        }
        
        if (candle.position.y <= cube.position.y && candle.position.y >= (cube.position.y-600)) && (candle.position.x <= cube.position.x+80 && candle.position.x >= cube.position.x-80){
            print("check")
            cube.run(SKAction.colorize(with: UIColor(displayP3Red: 20, green: 0, blue: 0, alpha: 1), colorBlendFactor: 0.1, duration: 0.1))
            
        }else{
            cube.run(SKAction.colorize(with: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1), colorBlendFactor: 0, duration: 0.1))

        }
    }
    
    func clear() {
     
          energy.text = ""
          equation.text = ""
    }
    
    
    
    
    func calculateFunction(initial: Double, power: Double, mass: Double) {
        if tagTT == 0 {
          if times.isEmpty == false {
               times.removeFirst()
          }
          firstUse = false
            //cube.run(SKAction.colorize(with: UIColor.gray, colorBlendFactor: 1, duration: 1))
          var difference = 0 - initial
          var thermalEnergy = 2100*mass*difference
          var time  = thermalEnergy/power
          if elementTT == "water"{
              cube.run(SKAction.animate(with: [SKTexture(imageNamed: "ice_cube"), SKTexture(imageNamed: "ice_cube_melt_1_3"),SKTexture(imageNamed: "ice_cube_melt_2_3")], timePerFrame: 0.1))
               state.text = "Solid and Liquid"
               temperatures.append(initialTT)
               times.append(0.0)
               temperatures.append(0.0)
               timeMain = time
               print("++++=========\(timeMain)")
          }else if elementTT == "aluminum"{
              // difference = 0-initial
              // thermalEnergy = 920*mass*difference
               let temperature = thermalEnergy/(920*mass)
               time  = thermalEnergy/power
               state.text = "Solid"
               temperatures.append(initialTT)
               times.append(0.0)
               temperatures.append(temperature)
               timeMain = time
          }
          energy.text = "Thermal Energy: \(thermalEnergy)W and Time: \(time.rounded())s"
          equation.text = "Equation: Q = cm∆T"
          print(energy.text!)
          print(timeMain)
          thermometerRed.run(SKAction.resize(toHeight: 2 , duration: 0.3))
          thermometerRed.run(SKAction.moveTo(y: 2/2, duration: 0.3))
         
          times.append(timeMain)
          print(temperatures)
          print(times)
        }
        
        if tagTT == 1{
          //temp magic
            let temp = 0.0
            let thermalEnergy = mass*340000
            var time = thermalEnergy/power
          if elementTT == "water"{
               cube.run(SKAction.animate(with: [SKTexture(imageNamed: "ice_cube_melt_2_3"),SKTexture(imageNamed: "ice_cube_melt_3_3")], timePerFrame: 0.1))
               state.text = "Liquid"
               energy.text = "Thermal Energy: \(thermalEnergy)W and Time: \(time.rounded())s"
               equation.text = "Equation: Q = mL (Latent heat of fusion)"
                temperatures.append(temp)
          }else if elementTT == "aluminum"{
               let temperature2 = thermalEnergy/(920*mass)
               
               temperatures.append(temperature2)
               time = thermalEnergy/power
               state.text = "Solid"
               energy.text = "Thermal Energy: \(thermalEnergy)W and Time: \(time.rounded())s"
                equation.text = "Equation: Q = cm∆T"
          }
            timeMain = time
          
            print(energy.text!)
            //cube.run(SKAction.colorize(with: UIColor(displayP3Red: 25, green: 10, blue: 100, alpha: 1), colorBlendFactor: 1, duration: 1))
            print(timeMain)
          thermometerRed.run(SKAction.resize(toHeight: 10 , duration: 0.3))
          thermometerRed.run(SKAction.moveTo(y: 10/2, duration: 0.3))

         
          times.append(timeMain)
          print(temperatures)
          print(times)
        }
        
        if tagTT == 2{
            let temp = 100.0
            var thermalEnergy = 4180*mass*100
            var time = thermalEnergy/power
          if elementTT == "water"{
               cube.run(SKAction.animate(with: [SKTexture(imageNamed: "ice_cube_melt_3_3"),SKTexture(imageNamed: "water")], timePerFrame: 0.1))
               state.text = "Liquid"


          }else if elementTT == "aluminum"{
               thermalEnergy = 920*mass*100
               time = thermalEnergy/power
               state.text = "Solid"
          }
            timeMain = time
            energy.text = "Thermal Energy: \(thermalEnergy)W and Time: \(time.rounded())s"
            equation.text = "Equation: Q = cm∆T"
            print(energy.text!)
            //cube.run(SKAction.colorize(with: UIColor.blue, colorBlendFactor: 1, duration: 1))
          thermometerRed.run(SKAction.resize(toHeight: 200 , duration: 0.3))
          thermometerRed.run(SKAction.moveTo(y: 200/2, duration: 0.3))

          temperatures.append(temp)
          times.append(timeMain)
          print(temperatures)
          print(times)
        }
        
        if tagTT == 3 {
            let temp = 100.0
          let thermalEnergy = mass*2300000
            var time = thermalEnergy/power
          if elementTT == "water"{
               cube.run(SKAction.animate(with: [SKTexture(imageNamed: "water"),SKTexture(imageNamed: "water_evaporating_2_3"),SKTexture(imageNamed: "water_evaporate_3_3"), SKTexture(imageNamed: "evaporated_water")], timePerFrame: 0.1))
               state.text = "Gas"
               energy.text = "Thermal Energy: \(thermalEnergy)W and Time: \(time.rounded())s"
               equation.text = "Equation: Q = mL(Latent heat of vaporization)"
                temperatures.append(temp)
          }else if elementTT == "aluminum"{
               let temperature = thermalEnergy/(920*mass)
               temperatures.append(temperature)
               time = thermalEnergy/power
              // cube.run(SKAction.animate(with: [SKTexture(imageNamed: "iron_block"), SKTexture(imageNamed: "iron_block_1_3"),SKTexture(imageNamed: "iron_block_2_3"),SKTexture(imageNamed: "iron_block_3_3"),SKTexture(imageNamed: "iron_molten")], timePerFrame: 0.1))
               state.text = "Solid"
               energy.text = "Thermal Energy: \(thermalEnergy)W and Time: \(time.rounded())s"
                equation.text = "Equation: Q = cm∆T"
          }
            timeMain = time
            print(energy.text!)
            //cube.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 1))
            print(timeMain)
         
          times.append(timeMain)
          let extraTime = (times[times.count-1])*2
          let extraTemp = 200.0
          temperatures.append(extraTemp)
          times.append(extraTime)
          print(temperatures)
          print(times)

        }
        
        if tagTT == 4 {
            //cube.texture = SKTexture(imageNamed: "ice_cube")
            //state.text = "Solid"
            //clear()
        }
    }
     
    func calculateOther(c: Double, m: Double, T: Double, p: Double, Lƒ: Double, Lv: Double, boilingPoint: Double) {
        if tagTT == 0 {
            let difference = 0-T
            let thermalEnergy = c*m*difference
            let time  = thermalEnergy/p
            energy.text = "Thermal Energy: \(thermalEnergy) and Time: \(time)"
            equation.text = "Equation: Q = cm∆T"
            
        }
        
        if tagTT == 1{
            let thermalEnergy = m*Lƒ
            let time = thermalEnergy/p
            energy.text = "Thermal Energy: \(thermalEnergy) and Time: \(time)"
            equation.text = "Equation: Q = mL (Latent heat of fusion)"
        }
        
        if tagTT == 2{
            let thermalEnergy = c*m*boilingPoint
            let time = thermalEnergy/p
            energy.text = "Thermal Energy: \(thermalEnergy) and Time: \(time)"
            equation.text = "Equation: Q = cm∆T"
        }
        
        if tagTT == 3 {
            let thermalEnergy = m*Lv
            let time = thermalEnergy/p
            energy.text = "Thermal Energy: \(thermalEnergy) and Time: \(time)"
            equation.text = "Equation: Q = mL(Latent heat of vaporation)"
        }
        if tagTT == 4{
            clear()
        }
        
        
        
    }
    
    
    func update() {
        if initialTT != nil && powerTT != nil && massTT != nil {
            //calculate.isEnabled=true
        }
    }
    
}
