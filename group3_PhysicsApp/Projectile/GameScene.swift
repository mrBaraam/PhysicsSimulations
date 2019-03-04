
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var projectileViewController: GameViewController?
    
    var TopScene: SKScene!
    var gameScene: SKScene!
    let cannonBallCategory: UInt32 = 0x1 << 0 // 1
    let groundCategory: UInt32 = 0x1 << 2 // 4
    
    var cam: SKCameraNode?
    var theCam: SKSpriteNode?
    var trailLayer: SKSpriteNode?
    var trailNode: SKShapeNode?
    let cam250 = SKCameraNode()
    let cam500 = SKCameraNode()
    let cam750 = SKCameraNode()
    let cam1000 = SKCameraNode()
    let cam1250 = SKCameraNode()
    
    private var theCannon = SKSpriteNode()
    private var ground =  SKSpriteNode()
    
    var toTopView: SKSpriteNode?
    var toRightView: SKSpriteNode?
    
    var angleLabel: SKLabelNode?
    var speedLabel: SKLabelNode?
    var gravityLabel: SKLabelNode?
    var massLabel: SKLabelNode?
    var editButton: SKLabelNode?
    var ManuButton: SKLabelNode?
    
    var setButton: SKLabelNode?
    var fireButton: SKLabelNode?
    var distanceLabel: SKLabelNode?
    var distancePlus: SKLabelNode?
    var distanceMinus: SKLabelNode?
    var plusBack: SKSpriteNode?
    var minusBack: SKSpriteNode?
    
    private var label : SKLabelNode?
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
       // self.projectileViewController = GameViewController()

    
        cameraDistance = 750
        
        self.addChild(cam250)
        self.addChild(cam500)
        self.addChild(cam750)
        self.addChild(cam1000)
        self.addChild(cam1250)
        
        cam250.position = CGPoint(x: 320, y: 200)
        cam250.xScale = 0.5
        cam250.yScale = 0.5
        
        cam500.position = CGPoint(x: 480, y: 300)
        cam500.xScale = 0.75
        cam500.yScale = 0.75
        
        cam1000.position = CGPoint(x: 800, y: 500)
        cam1000.xScale = 1.25
        cam1000.yScale = 1.25
        
        cam1250.position = CGPoint(x: 960, y: 600)
        cam1250.xScale = 1.5
        cam1250.yScale = 1.5
        
        
        
        cam = SKCameraNode()
        self.camera = cam
        self.addChild(cam!)
        
        theCam = self.childNode(withName: "theCam") as? SKSpriteNode
        trailLayer = self.childNode(withName: "trailLayer") as? SKSpriteNode
        createTheUI()
        setLabels()
        rotateCannon(desiredAngle: degreeAngle)
        
        self.scaleMode = .aspectFit
        
        
        if let theCannonNode = self.childNode(withName: "TheCannon") as? SKSpriteNode {
            theCannon = theCannonNode
        }
        
        if let theGroundNode = self.childNode(withName: "TheGround") as? SKSpriteNode {
            ground = theGroundNode
            ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2080, height: 40), center: CGPoint(x: 640, y: 20))
            
        }
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory
        ground.physicsBody?.contactTestBitMask = cannonBallCategory
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //when a ball hits the ground...
        if collision == groundCategory | cannonBallCategory {
            fireButton?.isHidden = false
            cannonBall?.physicsBody?.isDynamic = false
            cannonFired = false
            print("dis\(currentDistance)")
        }
    }
    
    
    func rotateCannon(desiredAngle: Double) {
        radianAngle = desiredAngle * (Double.pi / 180)
        let rotateAction = SKAction.rotate(toAngle: CGFloat(radianAngle) ,duration: 1)
        theCannon.run(rotateAction)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            print("\(node?.name)")
            
            if node?.name == "EDIT" {
                fireButton?.isHidden = false
            self.view?.window?.rootViewController?.performSegue(withIdentifier: "InsertInfo", sender: nil)
             
            } else if node?.name == "SET" {
                rotateCannon(desiredAngle: degreeAngle)
                print("xInit-\(xInitialSpeed)m/s, yInit-\(yInitialSpeed)m/s, gravity-\(gravity)m/s")
                setLabels()
            } else if node?.name == "FIRE" {
                print(cannonBall?.position)
                fireButton?.isHidden = true
                cannonFired = true
                self.physicsWorld.gravity = CGVector(dx: 0, dy: gravity)
                calculate(degree: degreeAngle, initialSpeed: initialSpeed, gravity: gravity, mass: mass)
                print("maxHeight-\(maximumHeight)m, distance-\(horizontalDistanceTravelled)m, time-\(totalTime)s, timeToMax-\(timeToReachTheMaximum)s")
                
                let ballRadius: CGFloat = 1
                
                cannonBall = SKSpriteNode(imageNamed: "cannonBall")
                cannonBall?.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
                cannonBall?.physicsBody?.velocity = CGVector(dx: xInitialSpeed, dy: yInitialSpeed)
                cannonBall?.zPosition = 1
                cannonBall?.position = CGPoint(x: 80, y: 100)
                cannonBall?.size = CGSize(width: 15, height: 15)
                cannonBall?.name = "cannonBall"
                cannonBall?.physicsBody?.collisionBitMask = groundCategory
                cannonBall?.physicsBody?.categoryBitMask = cannonBallCategory
                
                
                
                if ballArray.count == 3 {
                    for _ in 0..<ballArray.count {
                        ballArray[0].removeFromParent()
                        ballArray.remove(at: 0)
                    }
                    trailLayer?.removeAllChildren()
                }
                ballCount += 1
                self.addChild(cannonBall!)
                ballArray.append(cannonBall!)
                
                
            } else if node?.name == "PLUS" {
                guard cameraDistance == 1250 else {
                    cameraDistance += 250
                    adjustCam()
                    return
                }
                //adjustCam()
            } else if node?.name == "MINUS" {
                guard cameraDistance == 250 else {
                    cameraDistance -= 250
                    adjustCam()
                    return
                }
                
            }
            
            //if clicked on top arrow, go to top SKScene
             else if node?.name == "ToTopView" {
               
                
                if let view = self.view as! SKView? {
                    print("view set")
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "TopScene") as? TopScene{
                        print("scene set")
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        scene.topViewController = projectileViewController
                        // Present the scene
                        view.presentScene(scene, transition: .crossFade(withDuration: 0.5))
                    }
                }
                //if clicked on right arrow, go to right SKScene
            } else if node?.name == "ToRightView" {
                
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "RightScene") as? RightScene {
                        print("translation to right scene")
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFit
                        scene.rightSceneController = projectileViewController
                        // Present the scene
                        view.presentScene(scene, transition: .crossFade(withDuration: 0.5))
                        print("translation to right scene222")
                    }
                }
            } else if node?.name == "Manu"{
            // self.view?.presentScene(nil)
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
              
              
               
            
           // self.projectileViewController?.performSegue(withIdentifier: "projectileBackToManu", sender: nil)
            
                    // Load the SKScene from 'GameScene.sks'
                  
                
            } else {
                for t in touches { self.touchDown(atPoint: t.location(in: self)) }
            }
            
        }
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let camera = cam, let pl = theCam {
            camera.position = pl.position
        }
        // Called before each frame is rendered
        
        if cannonFired == true {
        currentDistance = (Double((cannonBall?.position.x)!) - 80) / 1.4
            trailNode = SKShapeNode(circleOfRadius: 5)
            trailNode?.fillColor = .white
            trailNode?.position = (cannonBall?.position)!
            trailLayer?.addChild(trailNode!)
        }
    }
    
    
    func createTheUI() {
        
        toTopView = SKSpriteNode(texture: SKTexture(imageNamed: "Arrow"))
        toTopView?.size = CGSize(width: 100, height: 150)
        toTopView?.xScale = 0.5
        toTopView?.yScale = 0.5
        toTopView?.zRotation = .pi / 2
        toTopView?.position = CGPoint(x: 0, y: 320)
        toTopView?.name = "ToTopView"
        camera?.addChild(toTopView!)
        
        toRightView = SKSpriteNode(texture: SKTexture(imageNamed: "Arrow"))
        toRightView?.size = CGSize(width: 100, height: 150)
        toRightView?.xScale = 0.5
        toRightView?.yScale = 0.5
        toRightView?.position = CGPoint(x: 560, y: 0)
        toRightView?.name = "ToRightView"
        camera?.addChild(toRightView!)
        
        angleLabel = SKLabelNode(text: "0°")
        angleLabel?.fontSize = 48
        angleLabel?.position = CGPoint(x: -480, y: 360)
        angleLabel?.name = "angleLabelNode"
        camera?.addChild(angleLabel!)
        
        speedLabel = SKLabelNode(text: "InitialSpeed:")
        speedLabel?.fontSize = 48
        speedLabel?.position = CGPoint(x: -480, y: 300)
        speedLabel?.name = "speedLabelNode"
        camera?.addChild(speedLabel!)
        
        gravityLabel = SKLabelNode(text: "Gravity:")
        gravityLabel?.position = CGPoint(x: -480, y: 240)
        gravityLabel?.fontSize = 48
        gravityLabel?.name = "gravityLabelNode"
        camera?.addChild(gravityLabel!)
        
        massLabel = SKLabelNode(text: "Mass:")
        massLabel?.position = CGPoint(x: -480, y: 180)
        massLabel?.fontSize = 48
        massLabel?.name = "massLabelNode"
        camera?.addChild(massLabel!)
        
        editButton = SKLabelNode(text: "EDIT")
        editButton?.position = CGPoint(x: -480, y: 90)
        editButton?.fontSize = 60
        editButton?.fontName = "Chalkduster"
        editButton?.name = "EDIT"
        camera?.addChild(editButton!)
        
        ManuButton = SKLabelNode(text: "Manu")
        ManuButton?.name = "Manu"
        ManuButton?.position = CGPoint(x: -480, y: 30)
        ManuButton?.fontSize = 60
        ManuButton?.fontName = "Chalkduster"
        camera?.addChild(ManuButton!)
     
            
      /*
             backToManuLabel.name = "Manu"
             backToManuLabel.text = "Manu"
             backToManuLabel.position = CGPoint(x: 560, y: 46)
             backToManuLabel.fontSize = 36
             addChild(backToManuLabel)
 
 */
        
        
        
        setButton = SKLabelNode(text: "SET")
        setButton?.position = CGPoint(x: 320, y: 320)
        setButton?.fontSize = 48
        setButton?.fontName = "Chalkduster"
        setButton?.name = "SET"
        camera?.addChild(setButton!)
        
        fireButton = SKLabelNode(text: "FIRE")
        fireButton?.position = CGPoint(x: 480, y: 320)
        fireButton?.fontSize = 48
        fireButton?.fontName = "Chalkduster"
        fireButton?.name = "FIRE"
        camera?.addChild(fireButton!)
        
        distanceLabel = SKLabelNode(text: "Distance")
        distanceLabel?.position = CGPoint(x: 400, y: 240)
        distanceLabel?.fontSize = 48
        distanceLabel?.fontName = "Chalkduster"
        distanceLabel?.name = "DISTANCE"
        camera?.addChild(distanceLabel!)
        
        distancePlus = SKLabelNode(text: "+")
        distancePlus?.fontColor = UIColor.black
        distancePlus?.position = CGPoint(x: 480, y: 180)
        distancePlus?.fontSize = 48
        distancePlus?.name = "+"
        camera?.addChild(distancePlus!)
        
        plusBack = SKSpriteNode(color: .green, size: CGSize(width: 40, height: 40))
        plusBack?.position = CGPoint(x: (distancePlus?.position.x)!, y: (distancePlus?.position.y)!+10)
        plusBack?.name = "PLUS"
        camera?.addChild(plusBack!)
        
        distanceMinus = SKLabelNode(text: "-")
        distanceMinus?.fontColor = UIColor.black
        distanceMinus?.position = CGPoint(x: 320, y: 180)
        distanceMinus?.fontSize = 56
        distanceMinus?.name = "-"
        camera?.addChild(distanceMinus!)
        
        minusBack = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        minusBack?.position = CGPoint(x: (distanceMinus?.position.x)!, y: (distanceMinus?.position.y)!+10)
        minusBack?.name = "MINUS"
        camera?.addChild(minusBack!)
        
        
        
    }
    
    func setLabels() {
        angleLabel?.text = "\(degreeAngle)°"
        speedLabel?.text = "Initial Speed: \(initialSpeed / 15)"
        gravityLabel?.text = "Gravity: \(gravity)"
        massLabel?.text = "Mass: \(mass)"
    }
    
    func adjustCam() {
        camera?.removeAllChildren()
        switch cameraDistance {
        case 250:
            camera = cam250
            createTheUI()
            setLabels()
        case 500:
            camera = cam500
            createTheUI()
            setLabels()
        case 750:
            camera = cam
            createTheUI()
            setLabels()
        case 1000:
            camera = cam1000
            createTheUI()
            setLabels()
        case 1250:
            camera = cam1250
            createTheUI()
            setLabels()
        default:
            camera = cam
            createTheUI()
            setLabels()
        }
    }
    
}
