//
//  GameScene.swift
//  BubblePop2
//
//  Created by Samuel Polgar on 13/4/2022.
//
//To do
// Make single balloon move and bounce from the walls
// Create 15 balloons
//
//
//

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

let maxGameDuration = 30;
let maxBalloonVelocity: CGFloat = 200
let maxBalloonAcceleration: CGFloat = 400

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

//SpriteKit easy language for games on iOS
import SpriteKit
//Core Motion reports motion- and environment-related data from the onboard hardware of iOS
import CoreMotion

enum CollisionTypes: UInt32 {
  case none = 0
  case all = 10
  case balloon = 0b1
}

class GameScene: SKScene {
//  let coreMotion = CMMotionManager()
  
  var balloonCount = 0;
  let gameBalloon: Balloon
  var balloonAcceleration = CGVector(dx: 0, dy: 0)
  var balloonVelocity = CGVector(dx: 0, dy: 0)
  var lastUpdateTime: CFTimeInterval = 0
  
  required init?(coder aDecoder: NSCoder) {
    gameBalloon = Balloon()
    super.init(coder: aDecoder)
    setup()
  }
  
  override init() {
    gameBalloon = Balloon()
    super.init()
    setup()
  }
  
  override init(size: CGSize) {
    gameBalloon = Balloon()
    super.init(size: size)
    setup()
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }

  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
    
  func setup() {
    //add balloons until 15 are on the screen simultaenously
    createSceneContents()
    addBalloons()
    physicsWorld.gravity = .zero
//    physicsWorld.contactDelegate = self
//    SKAction.run {
//      <#code#>
//    }
    
    }
  
  func createSceneContents(){
    self.backgroundColor = .black
    self.scaleMode = .aspectFit
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
  }
  
  func addBalloons(){
    //https://manualzz.com/doc/o/m7v9k/ios-swift-game-development-cookbook-chapterandnbsp%3B7.andnbsp%3Bphysics
    //https://stackoverflow.com/questions/28831312/ios-spritekit-make-random-moving-of-sprites-and-something-like-collision-in-spac
    //configure starting coordinates
    let balloonX = random(min: gameBalloon.size.width/2, max: size.width - gameBalloon.size.width/2)
    let velocityX = random(min: -75, max: 75)
    let velocityY = random(min: 50, max: 125)
    

    //add the child
    addChild(gameBalloon)
    let defaultImage = SKTexture(imageNamed: "pinkBalloon.png")
    gameBalloon.position = CGPoint(x: balloonX, y: gameBalloon.size.height)                 // create the balloon on the x/y axis near the bottom of the x
    gameBalloon.physicsBody = SKPhysicsBody(texture: gameBalloon.texture ?? defaultImage, size: gameBalloon.size )               // create a physics body around the balloon to let it move and interact
    gameBalloon.physicsBody?.isDynamic = true                                               // let the balloon move
    gameBalloon.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)              //set starting velocity
    
    //add collision https://developer.apple.com/documentation/scenekit/scnphysicsbody/1514768-categorybitmask/
    gameBalloon.physicsBody?.categoryBitMask = CollisionTypes.balloon.rawValue
    gameBalloon.physicsBody?.contactTestBitMask =  CollisionTypes.balloon.rawValue
    gameBalloon.physicsBody?.collisionBitMask = CollisionTypes.none.rawValue
    
//    gameBalloon.run(SKAction.sequence())
    
  }
  
  //updates the screen every second
  override func update(_ currentTime: TimeInterval) {
    let deltaTime = max(1.0/30, currentTime - lastUpdateTime)
    lastUpdateTime = currentTime
    updateBalloon(deltaTime)
  }
  
  //run this very often to check where the gameBalloons are
  func updateBalloon(_ dt: CFTimeInterval){
    
//    balloonVelocity.dx = balloonVelocity.dx * CGFloat(dt)         //playerVelocity.dx = playerVelocity.dx + playerAcceleration.dx * CGFloat(dt) - adds acceleration from core motion
//    balloonVelocity.dy = balloonVelocity.dy * CGFloat(dt)         //playerVelocity.dy = playerVelocity.dy + playerAcceleration.dy * CGFloat(dt) - adds acceleration from core motion
    
    balloonVelocity.dx = max(-maxBalloonVelocity, min(maxBalloonVelocity, balloonVelocity.dx))
    balloonVelocity.dy = max(-maxBalloonVelocity, min(maxBalloonVelocity, balloonVelocity.dy))
    print("Velocities : x \(balloonVelocity.dx)    and y \(balloonVelocity.dy)")
    
    var newX = gameBalloon.position.x + balloonVelocity.dx * CGFloat(dt)
    var newY = gameBalloon.position.y + balloonVelocity.dy * CGFloat(dt)
    
    print("newX : x \(newX)    and newY \(newY)")
    
    var hitVertical = false
    var hitHorizontal = false
    
    //check
    if newX < 0 {
      newX = 0
      hitHorizontal = true
    } else if newX > size.width {
      newX = size.width
      hitHorizontal = true
    }
    
    
    if newY < 0 {
      newY = 0
      hitVertical = true
    } else if newY > size.height {
      newY = size.height
      hitVertical = true
    }
    
    //if balloon hits vertical, change y velocity and acceleration
    if hitVertical {
      print("Hit vert")
      balloonVelocity.dx = balloonVelocity.dx
      balloonVelocity.dy = -balloonVelocity.dy
      
    }
    
    //if balloon hits horizontal, change x velocity and acceleration
    if hitHorizontal {
      print("Hit Horitzontal")
      //Change Velocity
      balloonVelocity.dx = -balloonVelocity.dx
      balloonVelocity.dy = balloonVelocity.dy
            
    }
    
    gameBalloon.position = CGPoint(x: newX, y: newY)
    
  }
  //change the direction of the balloon
//  let angle = atan2(playerVelocity.dy, playerVelocity.dx)
//  print("angle is \(angle)")
//  playerSprite.zRotation = angle - 90 * degreesToRadians
  
  
  
}

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
}

extension GameScene: SKPhysicsContactDelegate {
  
}
