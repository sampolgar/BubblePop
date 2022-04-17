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


struct PhysicsCategory {
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monster   : UInt32 = 0b1       // 1
  static let projectile: UInt32 = 0b10      // 2
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
    
    
              //bounce from the walls
    
//    gameBalloon.p
    
    
    //configure starting direction, between 0.5 radians and pie minus 0.5 radians
//    let startingX = random(min: -45, max: 45)
//    let startingY = random(min: 0, max: 1)
//    let angle = atan2(startingX, startingY)

//    let gameBalloon.
//    playerSprite.zRotation = angle - 90 * degreesToRadians
//    let initialBalloonDirection =
    
    // min angle: 10, max angle: 170
//    int min_angle = 10;
//    int max_angle = 170;
//    int degrees = arc4random_uniform(max_angle - min_angle) + min_angle;
//    float radians = degrees * M_PI/180.0f;
//    myVector = CGVectorMake(cos(radians), sin(radians));
    
    
//    //configure speed
//    let balloonDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
//
//    //add the child
//    addChild(gameBalloon)
//    gameBalloon.position = CGPoint(x: balloonX, y: gameBalloon.size.height)
//    gameBalloon.physicsBody?.velocity = CGVector(dx: 50, dy: 50)
//    gameBalloon.zRotation = angle - 90 * degreesToRadians
//    gameBalloon.zRotation = angle * degreesToRadians
    
    
//    print("printing the angle: \(angle)")
//    print("printing the angle minus 90: \(angle - 90)")
//    print("printing the radian: \(angle - 90 * degreesToRadians)")
    
    //add starting direction
    
    
//    print("ballon x min: \(gameBalloon.size.width/2) max: \(size.width - gameBalloon.size.width/2) ballon x \(balloonX)")
    
  }
  
  //updates the screen every second
  override func update(_ currentTime: TimeInterval) {
    let deltaTime = max(1.0/30, currentTime - lastUpdateTime)
    lastUpdateTime = currentTime
    updateBalloon(deltaTime)
  }
  
  
  func updateBalloon(_ dt: CFTimeInterval){
    
    balloonVelocity.dx = balloonVelocity.dx * CGFloat(dt)         //playerVelocity.dx = playerVelocity.dx + playerAcceleration.dx * CGFloat(dt) - adds acceleration from core motion
    balloonVelocity.dy = balloonVelocity.dy * CGFloat(dt)         //playerVelocity.dy = playerVelocity.dy + playerAcceleration.dy * CGFloat(dt) - adds acceleration from core motion
    
    
    
  }
  
  
}

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
}

extension GameScene: SKPhysicsContactDelegate {
  
}
