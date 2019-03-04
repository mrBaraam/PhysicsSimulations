
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class MagnetGameScene: SKScene {
    
   
    
    var spinnyMag: SKSpriteNode?
    var magnet: SKSpriteNode?
    var coilBack: SKSpriteNode?
    var coilFront: SKSpriteNode?
    var bulb: SKSpriteNode?
    var bulbBase: SKSpriteNode?
    var backToManuLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMove(to view: SKView) {
        
      
        
        createMagnets()
        backToManuLabel.name = "Menu"
        backToManuLabel.text = "Menu"
        backToManuLabel.position = CGPoint(x: 560, y: -250)
        backToManuLabel.fontSize = 60
        backToManuLabel.zPosition = 3
        addChild(backToManuLabel)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if magnetTouched == true {
            for touch in touches {
                let location = touch.location(in: self)
                magnet?.position.x = location.x
                magnet?.position.y = location.y
                
                xDist = Double((magnet?.position.x)! - (coilBack?.position.x)!)
                yDist = Double((magnet?.position.y)! - (coilBack?.position.y)!)
                
                totDist = (xDist * xDist + yDist * yDist).squareRoot()
                oldX = Double((magnet?.position.x)!)
                oldY = Double((magnet?.position.y)!)
                
                distanceBetweenOldAndNew = ((newX - oldX) * (newX - oldX) + (newY - oldY) * (newY - oldY)).squareRoot()
                
                if totDist > 0 && totDist < 240 && distanceBetweenOldAndNew > 0 {
                    switch distanceBetweenOldAndNew {
                    case 1..<15:
                        bulb?.texture = SKTexture(imageNamed: "bulb_2_5-1")
                    case 15..<30:
                        bulb?.texture = SKTexture(imageNamed: "bulb_3_5-1")
                    case 30..<45:
                        bulb?.texture = SKTexture(imageNamed: "bulb_4_5-1")
                    case 45..<240:
                        bulb?.texture = SKTexture(imageNamed: "bulb_5_5-1")
                    default:
                        bulb?.texture = SKTexture(imageNamed: "bulb_1_5-1")
                    }
                } else {
                    bulb?.texture = SKTexture(imageNamed: "bulb_1_5-1")
                }
                
                newX = Double((magnet?.position.x)!)
                newY = Double((magnet?.position.y)!)
                
               
            
            }
        } else if lightTouched == true {
            for touch in touches {
                let location = touch.location(in: self)
                bulbBase?.position.x = location.x
                bulbBase?.position.y = location.y
                
                xDist = Double((magnet?.position.x)! - (coilBack?.position.x)!)
                yDist = Double((magnet?.position.y)! - (coilBack?.position.y)!)
                
                totDist = (xDist * xDist + yDist * yDist).squareRoot()
                
                switch totDist {
                case 0..<80:
                    bulb?.texture = SKTexture(imageNamed: "bulb_5_5")
                case 80..<160:
                    bulb?.texture = SKTexture(imageNamed: "bulb_4_5")
                case 160..<240:
                    bulb?.texture = SKTexture(imageNamed: "bulb_3_5")
                case 240..<320:
                    bulb?.texture = SKTexture(imageNamed: "bulb_2_5")
                default:
                    bulb?.texture = SKTexture(imageNamed: "bulb_1_5")
                }
                
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            if node?.name == "MAGNET" {
                magnetTouched = true
           
            }else if node?.name == "Menu"{
                startingX = -640
                startingY = 320
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "MenuScene"){
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFit
                        // scene.projectileViewController = self
                        // Present the scene
                        view.presentScene(scene)
                        
                    }
                    
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    
                }
                
            } else {
                for t in touches { self.touchDown(atPoint: t.location(in: self)) }
            }
        }
        
        
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        magnetTouched = false
        lightTouched = false
        
        bulb?.texture = SKTexture(imageNamed: "bulb_1_5")
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered)
        
      var xPosition = magnet?.position.x
      var yPosition = magnet?.position.y
        for mag in spinnyArray {
        let x = mag.position.x
        let y = mag.position.y
            
            if x <= xPosition!-75 && y > yPosition! + 25{
                let side1 = xPosition!-75-x
                let side2 = y+25-(yPosition!+25)
                let angle = atan(side1/side2)
                
                var yDifference = sqrt(side1*side1+side2*side2)
                yDifference.round()
                
                switch yDifference {
                case 0...80: mag.zRotation = angle + .pi
                case 81...160: mag.zRotation = angle + .pi - .pi/36
                case 161...240: mag.zRotation = angle + .pi - .pi/18
                case 241...320:  mag.zRotation = angle + .pi - .pi/12
                case 321...404: mag.zRotation = angle + .pi - .pi/9
                default: mag.zRotation = angle + .pi - .pi/6
                }
        
            } else if x >= xPosition!-75 && x <= xPosition! + 75 && y > yPosition! + 25 {
                if x < xPosition! {
                    let xDifference = xPosition! - x
                    switch xDifference {
                    case 0...5: mag.zRotation = .pi/2 + .pi/36
                    case 6...10: mag.zRotation = .pi/2 + .pi/30
                    case 11...15: mag.zRotation = .pi/2 + .pi/24
                    case 16...20: mag.zRotation = .pi/2 + .pi/20
                    default: mag.zRotation = .pi/2 + .pi/16
                    }
                } else if x == xPosition! {
                    mag.zRotation = .pi/2
                } else if x > xPosition! {
                    let xDifference = x - xPosition!
                    switch xDifference {
                    case 0...5: mag.zRotation = .pi/2 - .pi/36
                    case 6...10: mag.zRotation = .pi/2 - .pi/30
                    case 11...15: mag.zRotation = .pi/2 - .pi/24
                    case 16...20: mag.zRotation = .pi/2 - .pi/20
                    default: mag.zRotation = .pi/2 - .pi/16
                    }
                }
            }else if x >= xPosition!+75 && y > yPosition! {
                let side1 = x - (xPosition! + 75)
                let side2 = (y+25) - (yPosition!+25)
                let angle = atan(side1/side2)
                var yDifference = sqrt(side1*side1 + side2*side2)
                yDifference.round()
                let original = -angle
                switch yDifference {
                case 0...80: mag.zRotation = -angle
                case 81...160: mag.zRotation = original + .pi/32
                case 161...240: mag.zRotation = original + .pi/18
                case 241...320:  mag.zRotation = original + .pi/12
                case 321...404: mag.zRotation = original + .pi/9
                default: mag.zRotation = original + .pi/6
                }
                
            } else if y == yPosition! && x <= xPosition!{
                
                     mag.zRotation = -(.pi/2)
               
            } else if x > xPosition! && y == yPosition!{
                     mag.zRotation = .pi/2
               
            } else if x < xPosition! - 125 && y < yPosition! {
                let side1 = xPosition!-75-x
                let side2 = yPosition!-y
                let angle = atan(side1/side2)
                var yDifference = sqrt(side1*side1+side2*side2)
                yDifference.round()
                
                
                let original = angle + .pi + .pi/2
                switch yDifference {
                case 0...80: mag.zRotation = angle
                case 81...160: mag.zRotation = original - .pi/6
                case 161...240: mag.zRotation = original - .pi/9
                case 241...320:  mag.zRotation = original - .pi/12
                case 321...404: mag.zRotation = original - .pi/18
                default: mag.zRotation = original - .pi/32
                }
                
                
                /*switch yDifference {
                case 0...80: mag.zRotation = angle + .pi/2 - .pi
                case 81...160: mag.zRotation = angle - .pi/36 + .pi/2 - .pi
                case 161...240: mag.zRotation = angle - .pi/18 + .pi/2 - .pi
                case 241...320:  mag.zRotation = angle - .pi/12 + .pi/2 - .pi
                case 321...404: mag.zRotation = angle - .pi/9 + .pi/2 - .pi
                default: mag.zRotation = angle - .pi/6 + .pi/2 - .pi
                }*/
            } else if x >= xPosition!-75 && x <= xPosition! + 75 && y < yPosition! + 25 {
                if x < xPosition! {
                    let xDifference = xPosition! - x
                    switch xDifference {
                    case 0...5: mag.zRotation = .pi/2 - .pi/36
                    case 6...10: mag.zRotation = .pi/2 - .pi/30
                    case 11...15: mag.zRotation = .pi/2 - .pi/24
                    case 16...20: mag.zRotation = .pi/2 - .pi/20
                    default: mag.zRotation = .pi/2 - .pi/16
                    }
                } else if x == xPosition! {
                    mag.zRotation = .pi/2
                } else if x > xPosition! {
                    let xDifference = x - xPosition!
                    switch xDifference {
                    case 0...5: mag.zRotation = .pi/2 + .pi/36
                    case 6...10: mag.zRotation = .pi/2 + .pi/30
                    case 11...15: mag.zRotation = .pi/2 + .pi/24
                    case 16...20: mag.zRotation = .pi/2 + .pi/20
                    default: mag.zRotation = .pi/2 + .pi/16
                    }
                }
            } else if y < yPosition! && x > xPosition! + 75 {
                let side1 = x - (xPosition!+75)
                let side2 = yPosition! - y
                let angle = atan(side1/side2)
                
                let yDifference = sqrt(side1*side1 + side2*side2)
                let original = angle + .pi
                switch yDifference {
                case 0...80: mag.zRotation = angle
                case 81...160: mag.zRotation = original - .pi/32
                case 161...240: mag.zRotation = original - .pi/18
                case 241...320:  mag.zRotation = original - .pi/12
                case 321...404: mag.zRotation = original - .pi/9
                default: mag.zRotation = original - .pi/6
                }
            }
            
            if y <= yPosition!+40 && x <= xPosition! && y >= yPosition!-40{
                
                mag.zRotation = -(.pi/2)
               
                
            } else if y <= yPosition!+40 && x > xPosition! && y >= yPosition!-40{
                mag.zRotation = .pi/2 + .pi
               
                
            }
            
            if x >= xPosition!-125 && x <= xPosition!-75 && y > yPosition!{
                let side1 = x - (xPosition!-125)
                var side2 = y - yPosition!
                let angle = atan(side1/side2)
                side2.round()
                switch side2 {
                case 0...80: mag.zRotation = angle + .pi
                case 81...160: mag.zRotation = angle + .pi + .pi/36
                case 161...240: mag.zRotation = angle + .pi + .pi/30
                case 241...320: mag.zRotation = angle + .pi + .pi/24
                default: mag.zRotation = angle + .pi + .pi/20
                }
                
            } else if x >= xPosition!-125 && x <= xPosition!-75 && y < yPosition! {
                let side1 = x - (xPosition!-125)
                var side2 = y - yPosition!
                let angle = atan(side1/side2)
                side2.round()
                switch side2 {
                case 0...80: mag.zRotation = angle
                case 81...160: mag.zRotation = angle  + .pi/36
                case 161...240: mag.zRotation = angle  + .pi/30
                case 241...320: mag.zRotation = angle + .pi/24
                default: mag.zRotation = angle + .pi/20
                }
                
            }
            
            if x >= xPosition!+75 && x <= xPosition!+125 && y > yPosition! {
                let side1 = x - (xPosition!+75)
                var side2 = y - yPosition!
                let angle = atan(side1/side2)
                side2.round()
                switch side2 {
                case 0...80: mag.zRotation = angle
                case 81...160: mag.zRotation = angle  + .pi/36
                case 161...240: mag.zRotation = angle  + .pi/30
                case 241...320: mag.zRotation = angle + .pi/24
                default: mag.zRotation = angle + .pi/20
                }
            } else if x >= xPosition!+75 && x <= xPosition!+125 && y < yPosition! {
                let side1 = x - (xPosition!-125)
                var side2 = y - yPosition!
                let angle = atan(side1/side2)
                side2.round()
                switch side2 {
                case 0...80: mag.zRotation = angle + .pi
                case 81...160: mag.zRotation = angle + .pi + .pi/36
                case 161...240: mag.zRotation = angle + .pi + .pi/30
                case 241...320: mag.zRotation = angle + .pi + .pi/24
                default: mag.zRotation = angle + .pi + .pi/20
                }
                
            }
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func createMagnet() {
        spinnyMag = SKSpriteNode(texture: SKTexture(imageNamed: "compass"))
        spinnyMag?.position = CGPoint(x: startingX, y: startingY)
        spinnyMag?.size = CGSize(width: 50, height: 50)
        creationCount += 1
        startingX += 80
        self.addChild(spinnyMag!)
        spinnyArray.append(spinnyMag!)
    }
    
    
    
    
    func createMagnets() {
        coilBack = SKSpriteNode(texture: SKTexture(imageNamed: "coil_back"))
        coilBack?.position = CGPoint(x: 400, y: 0)
        coilBack?.zPosition = 1
        coilBack?.size = CGSize(width: 200, height: 300)
        self.addChild(coilBack!)
        
        coilFront = SKSpriteNode(texture: SKTexture(imageNamed: "coil_front"))
        coilFront?.position = CGPoint(x: 400, y: 0)
        coilFront?.zPosition = 3
        coilFront?.size = CGSize(width: 200, height: 300)
        self.addChild(coilFront!)
        
        bulbBase = SKSpriteNode(texture: SKTexture(imageNamed: "bulb_base"))
        bulbBase?.position = CGPoint(x: 400, y: 10)
        bulbBase?.zPosition = 4
        bulbBase?.size = CGSize(width: 200, height: 400)
        bulbBase?.name = "LIGHT"
        self.addChild(bulbBase!)
        
        bulb = SKSpriteNode(texture: SKTexture(imageNamed: "bulb_1_5"))
        bulb?.position = CGPoint(x: 415, y: 150)
        bulb?.zPosition = 3
        bulb?.size = CGSize(width: 150, height: 150)
        self.addChild(bulb!)
        
        
        
        //big magnet
        magnet = SKSpriteNode(texture: SKTexture(imageNamed: "magnet1"))
        magnet?.position = CGPoint(x: 0, y: 0)
        magnet?.size = CGSize(width: 250, height: 50)
        magnet?.zPosition = 2
        magnet?.name = "MAGNET"
        self.addChild(magnet!)
        
        //all compasses
        for _ in 0...152 {
            createMagnet()
           
            if creationCount == 17 {
                creationCount = 0
                startingX = -640
                startingY -= 80
            }
        }
    }
    
    
}
