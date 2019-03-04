
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class TopScene: SKScene, SKPhysicsContactDelegate {
    
    var topViewController: GameViewController?
    
    let cannonBallCategory: UInt32 = 0x1 << 0 // 1
    let groundCategory: UInt32 = 0x1 << 2 // 4
    
    var topCam: SKCameraNode?
    var theTopCam: SKSpriteNode?
    var topTrailLayer: SKSpriteNode?
    var topTrailNode: SKShapeNode?
    let topCam250 = SKCameraNode()
    let topCam500 = SKCameraNode()
    let topCam750 = SKCameraNode()
    let topCam1000 = SKCameraNode()
    let topCam1250 = SKCameraNode()
    
    private var theTopCannon = SKSpriteNode()
    private var topGround =  SKSpriteNode()
    
    var toFrontFromTop: SKSpriteNode?
    
    var toFrontView: SKSpriteNode?
    
    var topAngleLabel: SKLabelNode?
    var topSpeedLabel: SKLabelNode?
    var topGravityLabel: SKLabelNode?
    var topMassLabel: SKLabelNode?
    var topEditButton: SKLabelNode?
    
    var topSetButton: SKLabelNode?
    var topFireButton: SKLabelNode?
    var topDistanceLabel: SKLabelNode?
    var topDistancePlus: SKLabelNode?
    var topDistanceMinus: SKLabelNode?
    var topPlusBack: SKSpriteNode?
    var topMinusBack: SKSpriteNode?
    
    var gameScene: SKScene!
    
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFit
        
        cameraDistance = 750
        
        self.addChild(topCam250)
        self.addChild(topCam500)
        self.addChild(topCam750)
        self.addChild(topCam1000)
        self.addChild(topCam1250)
        
        topCam250.position = CGPoint(x: 320, y: 0)
        topCam250.xScale = 0.5
        topCam250.yScale = 0.5
        
        topCam500.position = CGPoint(x: 480, y: 0)
        topCam500.xScale = 0.75
        topCam500.yScale = 0.75
        
        topCam1000.position = CGPoint(x: 800, y: 0)
        topCam1000.xScale = 1.25
        topCam1000.yScale = 1.25
        
        topCam1250.position = CGPoint(x: 960, y: 0)
        topCam1250.xScale = 1.5
        topCam1250.yScale = 1.5
        
        
        
        topCam = SKCameraNode()
        self.camera = topCam
        self.addChild(topCam!)
        
        theTopCam = self.childNode(withName: "theTopCam") as? SKSpriteNode
        topTrailLayer = self.childNode(withName: "topTrailLayer") as? SKSpriteNode
        createTheTopUI()
        setTopLabels()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let camera = topCam, let pl = theTopCam {
            camera.position = pl.position
        }
        // Called before each frame is rendered
        
        if cannonFired == true {
            currentDistance = (Double((cannonBall?.position.x)!) - 80) / 1.4
            topTrailNode = SKShapeNode(circleOfRadius: 5)
            topTrailNode?.fillColor = .white
            topTrailNode?.position = (cannonBall?.position)!
            topTrailNode?.zPosition = 4
            topTrailLayer?.addChild(topTrailNode!)
           // print(currentDistance)
            
            
            if currentDistance.rounded() > horizontalDistanceTravelled.rounded() {
                topFireButton?.isHidden = false
                cannonFired = false
                cannonBall?.physicsBody?.isDynamic = false
                cannonBall?.physicsBody?.isResting = true
                cannonBall?.physicsBody = nil

            }
            
        }
        
       
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            if node?.name == "topEDIT" {
                topFireButton?.isHidden = false
                self.view!.window!.rootViewController!.performSegue(withIdentifier: "InsertInfo", sender: self)
            } else if node?.name == "topSET" {
                setTopLabels()
            } else if node?.name == "topFIRE"{
                topFireButton?.isHidden = true
                cannonFired = true
                
                calculate(degree: degreeAngle, initialSpeed: initialSpeed, gravity: gravity, mass: mass)
                let ballRadius: CGFloat = 1
                self.physicsWorld.gravity = CGVector(dx: 0, dy: gravity)
                cannonBall = SKSpriteNode(imageNamed: "cannonBall")
                cannonBall?.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
                cannonBall?.physicsBody?.affectedByGravity = false
                cannonBall?.physicsBody?.velocity = CGVector(dx: xInitialSpeed, dy: 0)
                cannonBall?.zPosition = 5
                cannonBall?.position = CGPoint(x: 80, y: 0)
                cannonBall?.size = CGSize(width: 15, height: 15)
                cannonBall?.name = "cannonBall"
                
                if topBallArray.count == 3 {
                    for _ in 0..<topBallArray.count {
                        topBallArray[0].removeFromParent()
                        topBallArray.remove(at: 0)
                    }
                    topTrailLayer?.removeAllChildren()
                }
                topBallCount += 1
                self.addChild(cannonBall!)
                topBallArray.append(cannonBall!)
                
            } else if node?.name == "topPLUS" {
                guard cameraDistance == 1250 else {
                    cameraDistance += 250
                    adjustTopCam()
                    return
                }
                //adjustCam()
            } else if node?.name == "topMINUS" {
                guard cameraDistance == 250 else {
                    cameraDistance -= 250
                    adjustTopCam()
                    return
                }
                
            }
            
            //if clicked on top arrow, go to top SKScene
            if node?.name == "ToFrontFromTop" {
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
                        
                        scene.scaleMode = .aspectFill
                        scene.projectileViewController = topViewController
                        
                        view.presentScene(scene, transition: .crossFade(withDuration: 0.5))
                    }
                }
            }
        }
    }
    
    func createTheTopUI() {
        
        toFrontFromTop = SKSpriteNode(texture: SKTexture(imageNamed: "Arrow"))
        toFrontFromTop?.size = CGSize(width: 100, height: 150)
        toFrontFromTop?.xScale = 0.5
        toFrontFromTop?.yScale = 0.5
        toFrontFromTop?.zRotation = (.pi * 3) / 2
        toFrontFromTop?.position = CGPoint(x: 0, y: -320)
        toFrontFromTop?.name = "ToFrontFromTop"
        camera?.addChild(toFrontFromTop!)
        
        
        topAngleLabel = SKLabelNode(text: "0°")
        topAngleLabel?.position = CGPoint(x: -480, y: 360)
        topAngleLabel?.fontSize = 48
        topAngleLabel?.name = "topAngleLabelNode"
        camera?.addChild(topAngleLabel!)
        
        topSpeedLabel = SKLabelNode(text: "InitialSpeed:")
        topSpeedLabel?.position = CGPoint(x: -480, y: 300)
        topSpeedLabel?.fontSize = 48
        topSpeedLabel?.name = "topSpeedLabelNode"
        camera?.addChild(topSpeedLabel!)
        
        topGravityLabel = SKLabelNode(text: "Gravity:")
        topGravityLabel?.position = CGPoint(x: -480, y: 240)
        topGravityLabel?.fontSize = 48
        topGravityLabel?.name = "topGravityLabelNode"
        camera?.addChild(topGravityLabel!)
        
        topMassLabel = SKLabelNode(text: "Mass:")
        topMassLabel?.position = CGPoint(x: -480, y: 180)
        topMassLabel?.fontSize = 48
        topMassLabel?.name = "topMassLabelNode"
        camera?.addChild(topMassLabel!)
        
        topEditButton = SKLabelNode(text: "EDIT")
        topEditButton?.position = CGPoint(x: -480, y: 120)
        topEditButton?.fontSize = 56
        topEditButton?.name = "topEDIT"
       // camera?.addChild(topEditButton!)
        
        topSetButton = SKLabelNode(text: "SET")
        topSetButton?.position = CGPoint(x: 300, y: 320)
        topSetButton?.fontSize = 56
        topSetButton?.name = "topSET"
        camera?.addChild(topSetButton!)
        
        topFireButton = SKLabelNode(text: "FIRE")
        topFireButton?.position = CGPoint(x: 480, y: 320)
        topFireButton?.fontSize = 56
        topFireButton?.name = "topFIRE"
        camera?.addChild(topFireButton!)
        
        topDistanceLabel = SKLabelNode(text: "Distance")
        topDistanceLabel?.position = CGPoint(x: 400, y: 240)
        topDistanceLabel?.fontSize = 48
        topDistanceLabel?.name = "topDISTANCE"
        camera?.addChild(topDistanceLabel!)
        
        topDistancePlus = SKLabelNode(text: "+")
        topDistancePlus?.position = CGPoint(x: 480, y: 180)
        topDistancePlus?.fontColor = UIColor.black
        topDistancePlus?.fontSize = 48
        topDistancePlus?.name = "+"
        camera?.addChild(topDistancePlus!)
        
        topPlusBack = SKSpriteNode(color: .green, size: CGSize(width: 40, height: 40))
        
         topPlusBack?.position = CGPoint(x: (topDistancePlus?.position.x)!, y: (topDistancePlus?.position.y)!+10)
        topPlusBack?.name = "topPLUS"
        camera?.addChild(topPlusBack!)
        
        topDistanceMinus = SKLabelNode(text: "-")
        topDistanceMinus?.position = CGPoint(x: 320, y: 180)
        topDistanceMinus?.name = "-"
        topDistanceMinus?.fontSize = 48
        topDistanceMinus?.fontColor = UIColor.black
        camera?.addChild(topDistanceMinus!)
        
        topMinusBack = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        topMinusBack?.position = CGPoint(x: (topDistanceMinus?.position.x)!, y: (topDistanceMinus?.position.y)!+10)
        topMinusBack?.name = "topMINUS"
        camera?.addChild(topMinusBack!)
    }
    
    func setTopLabels() {
        topAngleLabel?.text = "\(degreeAngle)°"
        topSpeedLabel?.text = "Initial Speed: \(initialSpeed / 15)"
        topGravityLabel?.text = "Gravity: \(gravity)"
        topMassLabel?.text = "Mass: \(mass)"
    }
    
    func adjustTopCam() {
        camera?.removeAllChildren()
        switch cameraDistance {
        case 250:
            camera = topCam250
            createTheTopUI()
            setTopLabels()
        case 500:
            camera = topCam500
            createTheTopUI()
            setTopLabels()
        case 750:
            camera = topCam
            createTheTopUI()
            setTopLabels()
        case 1000:
            camera = topCam1000
            createTheTopUI()
            setTopLabels()
        case 1250:
            camera = topCam1250
            createTheTopUI()
            setTopLabels()
        default:
            camera = topCam
            createTheTopUI()
            setTopLabels()
        }
    }
}
