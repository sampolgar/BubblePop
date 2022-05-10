//
//  Balloon.swift
//  BubblePop
//
//  Created by Samuel Polgar on 12/4/2022.
//After a long time troubleshooting, there is a bug in skspritenode
//https://stackoverflow.com/questions/47169966/setting-physics-body-in-initializer-of-skspritenode-custom-subclass-doesnt-work

import SpriteKit

let maxGameDuration = 60;

class Balloon: SKSpriteNode {
    var balloonColor: String?
    var gameScore: Double?
    var width: CGFloat
    var height: CGFloat
    
    
    init (gameScene: SKScene) {
        let balloonSize = CGSize(width: 150, height: 150)
        
        width = gameScene.frame.width
        height = gameScene.frame.height
        
        super.init(texture: nil, color: UIColor.clear, size: balloonSize)
        
        setupGameRequirements()
        
        print(self)
        
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
    
    func setupPhysics(){
        //create physics
//        let defaultImage = SKTexture(imageNamed: "pinkBalloon.png")
//        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
//        self.physicsBody = SKPhysicsBody(texture: self.texture ?? defaultImage, size: self.size)
//        //set random x and y coordinates
//
//        let balloonX = random(min: self.size.width*2, max: width  - self.size.width*2)
//        let balloonY = random(min: self.size.height*2, max: height - self.size.height*2)
//        self.position = CGPoint(x: balloonX, y: balloonY)                 // create the balloon on random x/y
//
//        //set random velocities
//        let velocityX = random(min: -200, max: 100)
//        let velocityY = random(min: -250, max: 250)
//        //set random impulse
//        let impulseX = random(min: -5, max: 5)
//        let impulseY = random(min: -5, max: 5)
//
//
//        self.physicsBody?.friction = 0
//        self.physicsBody?.restitution = 1
//        self.physicsBody?.angularDamping = 0
//        self.physicsBody?.linearDamping = 0
//        self.physicsBody?.angularDamping = 0
//        self.physicsBody?.isDynamic = true
//
//        //set starting velocity
//        self.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
//        self.physicsBody!.applyImpulse(CGVector(dx: impulseX, dy: impulseY))
//
//        /*
//         categoryBitMask - number defining the type of object this is for considering collisions
//         collisionBitMask - number defining what categories of object this node should collide with
//         contactTestBitMask - number defining which collisions we want to be notified about
//         */
//        self.physicsBody?.categoryBitMask = PhysicsCategory.balloon
//        self.physicsBody?.collisionBitMask = PhysicsCategory.all
//        print(self)
//        print("here in physics")
    }
}


//functions

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

func randomInteger(min: Int, max: Int) -> Int {
    return Int.random(in: min...max)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
