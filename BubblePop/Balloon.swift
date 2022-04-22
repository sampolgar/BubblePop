//
//  Balloon.swift
//  BubblePop
//
//  Created by Samuel Polgar on 12/4/2022.
//
import SpriteKit

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

let maxGameDuration = 60;
let maxBalloonVelocity: CGFloat = 200
let maxBalloonAcceleration: CGFloat = 400

func random() -> CGFloat {
  return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
  return random() * (max - min) + min
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}



class Balloon: SKSpriteNode {
    var balloonColor: String?
    var gameScore: Double?
    
    
    init () {
        let balloonSize = CGSize(width: 100, height: 100)
        
        super.init(texture: nil, color: UIColor.clear, size: balloonSize)
        setupGameRequirements()
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupGameRequirements() {
        let randomInt = Int.random(in: 0..<100)
        switch randomInt
        {
        case 0..<40:
            self.balloonColor = "red"
            self.gameScore = 1.0
            self.texture = SKTexture(imageNamed: "redBalloon.png")
        case 40..<70:
            self.balloonColor = "pink"
            self.gameScore = 2.0
            self.texture = SKTexture(imageNamed: "pinkBalloon.png")
        case 70..<85:
            self.balloonColor = "green"
            self.gameScore = 5.0
            self.texture = SKTexture(imageNamed: "greenBalloon.png")
        case 85..<95:
            self.balloonColor = "blue"
            self.gameScore = 8.0
            self.texture = SKTexture(imageNamed: "blueBalloon.png")
        case 95..<100:
            self.balloonColor = "black"
            self.gameScore = 10.0
            self.texture = SKTexture(imageNamed: "blackBalloon.png")
        default:
            self.balloonColor = "nil"
            self.gameScore = 0.0
        }
    }
    
    private func setupPhysics(){
        let defaultImage = SKTexture(imageNamed: "pinkBalloon.png")
        let balloonX = random(min: self.size.width/2, max: (self.scene?.size.width ?? 100 - self.size.width/2))
        let balloonY = random(min: self.size.height/2, max: (self.scene?.size.height ?? 100 - self.size.height/2))
        let velocityX = random(min: -75, max: 75)
        let velocityY = random(min: 125, max: 250)
        
        self.position = CGPoint(x: balloonX, y: balloonY)                 // create the balloon on the 
        
        //setup physics
        self.physicsBody = SKPhysicsBody(texture: self.texture ?? defaultImage, size: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.isDynamic = true
        
        //set starting velocity
        self.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
        
        /*
         categoryBitMask - number defining the type of object this is for considering collisions
         collisionBitMask - number defining what categories of object this node should collide with
         contactTestBitMask - number defining which collisions we want to be notified about
         */
        self.physicsBody?.categoryBitMask = PhysicsCategory.balloon
        self.physicsBody?.collisionBitMask = PhysicsCategory.all
        self.physicsBody?.contactTestBitMask = PhysicsCategory.balloonPopper
    }
}
