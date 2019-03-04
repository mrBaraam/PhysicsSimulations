//
//  Variables.swift
//  ProjectileMotionSK
//
//  Created by Period Three on 2018-11-22.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit
import GameplayKit

var cannonBall: SKSpriteNode?
var ballCount: Int = 0
var ballArray: [SKSpriteNode] = []

var rightBallCount: Int = 0
var rightBallArray: [SKSpriteNode] = []

var topBallCount: Int = 0
var topBallArray: [SKSpriteNode] = []

var currentScene: Int = 0
var cameraDistance: Int = 750

var degreeAngle: Double = 0.0
var radianAngle: Double = 0.0
var initialSpeed: Double = 0.0

var scaledXSpeed: Double = 0.0
var scaledYSpeed: Double = 0.0

var xInitialSpeed: Double = 0.0
var yInitialSpeed: Double = 0.0
var gravity: Double = -9.8
var topSceneGravity: Double = 0.0
var mass: Double = 1.0

var totalTime: Double = 0.0
var timeToReachTheMaximum: Double = 0.0
var maximumHeight: Double = 0.0
var horizontalDistanceTravelled: Double = 0.0

var currentHeight: Double = 0.0
var currentDistance: Double = 0.0
var ballStartPoint: Double = 80.0
var cannonFired: Bool = false


var angleLabel: SKLabelNode?
var speedLabel: SKLabelNode?
var gravityLabel: SKLabelNode?
var massLabel: SKLabelNode?
var editButton: SKLabelNode?

var setButton: SKLabelNode?
var fireButton: SKLabelNode?

//var views: [SKView] = [GameScene, RightScene, TopScene]




func calculate(degree: Double, initialSpeed:Double, gravity: Double, mass: Double) {
    let pi = Double.pi
    
    xInitialSpeed = initialSpeed*cos(Double(degree)*(pi/180))
    yInitialSpeed = initialSpeed*sin(Double(degree)*(pi/180))
    
    scaledXSpeed = (initialSpeed/15)*cos(Double(degree)*(pi/180))
    scaledYSpeed = (initialSpeed/15)*sin(Double(degree)*(pi/180))
    
    totalTime = scaledYSpeed/(-0.5*gravity)
    
    //totalTimeLabel.text = "\(totalTime)"
    
    timeToReachTheMaximum = (0-Double(scaledYSpeed))/gravity
    //timeToReachMaximumHeightLabel.text = "\(timeToReachTheMaximum)"
    maximumHeight = (-Double(scaledYSpeed)*Double(scaledYSpeed))/(2*gravity)
    //maximumHeightLabel.text = "\(maximumHeight)"
    horizontalDistanceTravelled = Double(scaledXSpeed)*totalTime
    //horizontalDistanceLabel.text = "\(horizontalDistanceTravelled)"
    
    
}



