
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class RightScene: SKScene, SKPhysicsContactDelegate {
    
    
    var rightSceneController: GameViewController?
    let rightCannonBallCategory: UInt32 = 0x1 << 0 // 1
    let rightGroundCategory: UInt32 = 0x1 << 2 // 4
    
    var rightCam: SKCameraNode?
    var theRightCam: SKSpriteNode?
    var rightTrailLayer: SKSpriteNode?
    var rightTrailNode: SKShapeNode?
    let rightCam250 = SKCameraNode()
    let rightCam500 = SKCameraNode()
    let rightCam750 = SKCameraNode()
    let rightCam1000 = SKCameraNode()
    let rightCam1250 = SKCameraNode()
    
    private var theRightCannon = SKSpriteNode()
    private var rightGround =  SKSpriteNode()
    
    var toFrontView: SKSpriteNode?
    
    
    var rightAngleLabel: SKLabelNode?
    var rightSpeedLabel: SKLabelNode?
    var rightGravityLabel: SKLabelNode?
    var rightMassLabel: SKLabelNode?
    var rightEditButton: SKLabelNode?
    
    var rightSetButton: SKLabelNode?
    var rightFireButton: SKLabelNode?
    var rightDistanceLabel: SKLabelNode?
    var rightDistancePlus: SKLabelNode?
    var rightDistanceMinus: SKLabelNode?
    var rightPlusBack: SKSpriteNode?
    var rightMinusBack: SKSpriteNode?
    
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        print("right scene load")
        
        cameraDistance = 750
        
        self.addChild(rightCam250)
        self.addChild(rightCam500)
        self.addChild(rightCam750)
        self.addChild(rightCam1000)
        self.addChild(rightCam1250)
        
        rightCam250.position = CGPoint(x: 0, y: 200)
        rightCam250.xScale = 0.5
        rightCam250.yScale = 0.5
        
        rightCam500.position = CGPoint(x: 0, y: 300)
        rightCam500.xScale = 0.75
        rightCam500.yScale = 0.75
        
        rightCam1000.position = CGPoint(x: 0, y: 500)
        rightCam1000.xScale = 1.25
        rightCam1000.yScale = 1.25
        
        rightCam1250.position = CGPoint(x: 0, y: 600)
        rightCam1250.xScale = 1.5
        rightCam1250.yScale = 1.5
        
        
        
        rightCam = SKCameraNode()
        self.camera = rightCam
        self.addChild(rightCam!)
        
        theRightCam = self.childNode(withName: "theRightCam") as? SKSpriteNode
        rightTrailLayer = self.childNode(withName: "rightTrailLayer") as? SKSpriteNode
        createTheRightUI()
        setRightLabels()
        
        self.scaleMode = .aspectFit
        
        
        if let theRightCannonNode = self.childNode(withName: "TheRightCannon") as? SKSpriteNode {
            theRightCannon = theRightCannonNode
        }
        
        if let theRightGroundNode = self.childNode(withName: "TheRightGround") as? SKSpriteNode {
            rightGround = theRightGroundNode
            rightGround.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2080, height: 40), center: CGPoint(x: 0, y: 20))
            
        }
        rightGround.physicsBody?.affectedByGravity = false
        rightGround.physicsBody?.isDynamic = false
        rightGround.physicsBody?.categoryBitMask = rightGroundCategory
        rightGround.physicsBody?.contactTestBitMask = rightCannonBallCategory
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let topCollision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //when a ball hits the ground...
        if topCollision == rightGroundCategory | rightCannonBallCategory {
            rightFireButton?.isHidden = false
            cannonBall?.physicsBody?.isDynamic = false
            cannonFired = false
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            if node?.name == "rightEDIT" {
                rightFireButton?.isHidden = false
                self.rightSceneController?.performSegue(withIdentifier: "InsertInfo", sender: nil)
            } else if node?.name == "rightSET" {
                print("xInit-\(xInitialSpeed)m/s, yInit-\(yInitialSpeed)m/s, gravity-\(gravity)m/s")
                setRightLabels()
            } else if node?.name == "rightFIRE" {
                rightFireButton?.isHidden = true
                cannonFired = true
                print(cannonBall?.position)
                
                self.physicsWorld.gravity = CGVector(dx: 0, dy: gravity)
                calculate(degree: degreeAngle, initialSpeed: initialSpeed, gravity: gravity, mass: mass)
                print("maxHeight-\(maximumHeight)m, distance-\(horizontalDistanceTravelled)m, time-\(totalTime)s, timeToMax-\(timeToReachTheMaximum)s")
                
                let ballRadius: CGFloat = 1
                
                cannonBall = SKSpriteNode(imageNamed: "cannonBall")
                cannonBall?.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
                cannonBall?.physicsBody?.velocity = CGVector(dx: 0, dy: yInitialSpeed)
                cannonBall?.zPosition = 1
                cannonBall?.position = CGPoint(x: 0, y: 100)
                cannonBall?.size = CGSize(width: 15, height: 15)
                cannonBall?.name = "cannonBall"
                cannonBall?.physicsBody?.collisionBitMask = rightGroundCategory
                cannonBall?.physicsBody?.categoryBitMask = rightCannonBallCategory
                
                
                
                if rightBallArray.count == 3 {
                    for _ in 0..<rightBallArray.count {
                        rightBallArray[0].removeFromParent()
                        rightBallArray.remove(at: 0)
                    }
                    rightTrailLayer?.removeAllChildren()
                }
                rightBallCount += 1
                self.addChild(cannonBall!)
                rightBallArray.append(cannonBall!)
                
                
            } else if node?.name == "rightPLUS" {
                guard cameraDistance == 1250 else {
                    cameraDistance += 250
                    adjustCam()
                    return
                }
                //adjustCam()
            } else if node?.name == "rightMINUS" {
                guard cameraDistance == 250 else {
                    cameraDistance -= 250
                    adjustCam()
                    return
                }
                
            }
                
                //if clicked on top arrow, go to top SKScene
            else if node?.name == "ToFrontFromRight" {
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene"){
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        //scene.projectileViewController = rightSceneController
                       
                        view.presentScene(scene, transition: .crossFade(withDuration: 0.5))
                    }
                }
                //if clicked on right arrow, go to right SKScene
            }
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let camera = rightCam, let pl = theRightCam {
            camera.position = pl.position
        }
        
        if cannonFired == true {
            rightTrailNode = SKShapeNode(circleOfRadius: 5)
            rightTrailNode?.fillColor = .white
            rightTrailNode?.position = (cannonBall?.position)!
            rightTrailLayer?.addChild(rightTrailNode!)
        }
    }
    
    func createTheRightUI() {
        
        
        toFrontView = SKSpriteNode(texture: SKTexture(imageNamed: "Arrow"))
        toFrontView?.size = CGSize(width: 100, height: 150)
        toFrontView?.xScale = 0.5
        toFrontView?.yScale = 0.5
        toFrontView?.zRotation = .pi
        toFrontView?.position = CGPoint(x: -560, y: 0)
        toFrontView?.name = "ToFrontFromRight"
        camera?.addChild(toFrontView!)
        
        rightAngleLabel = SKLabelNode(text: "0°")
        rightAngleLabel?.position = CGPoint(x: -480, y: 360)
        rightAngleLabel?.fontSize = 48
        rightAngleLabel?.name = "rightAngleLabelNode"
        camera?.addChild(rightAngleLabel!)
        
        rightSpeedLabel = SKLabelNode(text: "InitialSpeed:")
        rightSpeedLabel?.position = CGPoint(x: -480, y: 300)
        rightSpeedLabel?.fontSize = 48
        rightSpeedLabel?.name = "rightSpeedLabelNode"
        camera?.addChild(rightSpeedLabel!)
        
        rightGravityLabel = SKLabelNode(text: "Gravity:")
        rightGravityLabel?.position = CGPoint(x: -480, y: 240)
        rightGravityLabel?.fontSize = 48
        rightGravityLabel?.name = "rightGravityLabelNode"
        camera?.addChild(rightGravityLabel!)
        
        rightMassLabel = SKLabelNode(text: "Mass:")
        rightMassLabel?.position = CGPoint(x: -480, y: 180)
        rightMassLabel?.fontSize = 48
        rightMassLabel?.name = "rightMassLabelNode"
        camera?.addChild(rightMassLabel!)
        
        rightEditButton = SKLabelNode(text: "EDIT")
        rightEditButton?.position = CGPoint(x: -480, y: 120)
        rightEditButton?.fontSize = 56
        rightEditButton?.fontName = "Chalkduster"
        rightEditButton?.name = "rightEDIT"
        //camera?.addChild(rightEditButton!)
        
        rightSetButton = SKLabelNode(text: "SET")
        rightSetButton?.position = CGPoint(x: 300, y: 320)
        rightSetButton?.fontSize = 56
        rightSetButton?.fontName = "Chalkduster"
        rightSetButton?.name = "rightSET"
        camera?.addChild(rightSetButton!)
        
        rightFireButton = SKLabelNode(text: "FIRE")
        rightFireButton?.position = CGPoint(x: 480, y: 320)
        rightFireButton?.fontSize = 56
        rightFireButton?.fontName = "Chalkduster"
        rightFireButton?.name = "rightFIRE"
        camera?.addChild(rightFireButton!)
        
        rightDistanceLabel = SKLabelNode(text: "Distance")
        rightDistanceLabel?.position = CGPoint(x: 400, y: 240)
        rightDistanceLabel?.fontSize = 48
        rightDistanceLabel?.fontName = "Chalkduster"
        rightDistanceLabel?.name = "rightDISTANCE"
        camera?.addChild(rightDistanceLabel!)
        
        rightDistancePlus = SKLabelNode(text: "+")
        rightDistancePlus?.position = CGPoint(x: 480, y: 180)
        rightDistancePlus?.fontColor = UIColor.black
        rightDistancePlus?.fontSize = 48
        rightDistancePlus?.name = "+"
        camera?.addChild(rightDistancePlus!)
        
        rightPlusBack = SKSpriteNode(color: .green, size: CGSize(width: 40, height: 40))
        
        rightPlusBack?.position = CGPoint(x: (rightDistancePlus?.position.x)!, y: (rightDistancePlus?.position.y)!+10)
        rightPlusBack?.name = "rightPLUS"
        camera?.addChild(rightPlusBack!)
        
        rightDistanceMinus = SKLabelNode(text: "-")
        rightDistanceMinus?.position = CGPoint(x: 320, y: 180)
        rightDistanceMinus?.fontColor = UIColor.black
        rightDistanceMinus?.fontSize = 48
        rightDistanceMinus?.name = "-"
        camera?.addChild(rightDistanceMinus!)
        
        rightMinusBack = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        rightMinusBack?.position = CGPoint(x: (rightDistanceMinus?.position.x)!, y: (rightDistanceMinus?.position.y)!+10)
        rightMinusBack?.name = "rightMINUS"
        camera?.addChild(rightMinusBack!)
        
        
        
    }
    
    func setRightLabels() {
        rightAngleLabel?.text = "\(degreeAngle)°"
        rightSpeedLabel?.text = "Initial Speed: \(initialSpeed / 15)"
        rightGravityLabel?.text = "Gravity: \(gravity)"
        rightMassLabel?.text = "Mass: \(mass)"
    }
    
    func adjustCam() {
        camera?.removeAllChildren()
        switch cameraDistance {
        case 250:
            camera = rightCam250
            createTheRightUI()
            setRightLabels()
        case 500:
            camera = rightCam500
            createTheRightUI()
            setRightLabels()
        case 750:
            camera = rightCam
            createTheRightUI()
            setRightLabels()
        case 1000:
            camera = rightCam1000
            createTheRightUI()
            setRightLabels()
        case 1250:
            camera = rightCam1250
            createTheRightUI()
            setRightLabels()
        default:
            camera = rightCam
            createTheRightUI()
            setRightLabels()
        }
    }
}
