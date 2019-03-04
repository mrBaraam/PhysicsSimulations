
import UIKit
import Foundation
import SpriteKit
import GameplayKit


var spinnyArray: [SKSpriteNode] = []
var startingX = -640
var startingY = 320
var creationCount = 0

var xDist: Double = 0
var yDist: Double = 0
var totDist: Double = 0

var magnetTouched: Bool = false
var lightTouched: Bool = false

var newX: Double = 0
var newY: Double = 0

var oldX: Double = 0
var oldY: Double = 0


var distanceBetweenOldAndNew: Double = 0
