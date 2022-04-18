//
//  BalloonPopper.swift
//  BubblePop
//
//  Created by Samuel Polgar on 18/4/2022.
//
import SpriteKit

class BalloonPopper: SKSpriteNode {
    
    init () {
        let popSize = CGSize(width: 50, height: 50)
        let popTexture = SKTexture(imageNamed: "pin.png")
        super.init(texture: popTexture, color: UIColor.clear, size: popSize)
        setup()
    }
    
    private func setup(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: 25)              // create a physics body around the balloon to let it
        self.physicsBody?.categoryBitMask = PhysicsCategory.balloonPopper
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.contactTestBitMask = PhysicsCategory.balloon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
