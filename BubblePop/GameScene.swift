//
//  GameScene.swift
//  BubblePop
//
//  Created by Samuel Polgar on 12/4/2022.
//
import SpriteKit

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

class GameScene: SKScene
{
    
    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.white
        run(SKAction.repeatForever(
              SKAction.sequence([
                SKAction.run(addBalloon),
                SKAction.wait(forDuration: 1.0)
                ])
            ))
    }
    
    struct PhysicsCategory {
      static let none      : UInt32 = 0
      static let all       : UInt32 = UInt32.max
      static let balloon   : UInt32 = 0b1       // 1
    }
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    //gives random points
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
    func addBalloon()
    {
        let balloonNode = BalloonNode()
        
        balloonNode.physicsBody                                 = SKPhysicsBody(circleOfRadius: balloonNode.size.width/2)
        balloonNode.physicsBody?.isDynamic                      = true
        balloonNode.physicsBody?.categoryBitMask                = PhysicsCategory.balloon
        balloonNode.physicsBody?.contactTestBitMask             = PhysicsCategory.balloon
        balloonNode.physicsBody?.collisionBitMask               = PhysicsCategory.balloon
        balloonNode.physicsBody?.friction                       = 0.0
        balloonNode.physicsBody?.affectedByGravity              = true;
        balloonNode.physicsBody?.usesPreciseCollisionDetection  = true

        
        //find where to spawn the balloon - the balloon needs to be 100% on the screen
        let startingY = random(min: balloonNode.size.height/2, max:size.height - balloonNode.size.height/2)
        let startingX = random(min: balloonNode.size.width/2, max:size.width - balloonNode.size.width/2)
    
        balloonNode.position = CGPoint(x: startingX, y: startingY)
        
        addChild(balloonNode)
        
        let balloonSpeed        = random(min: CGFloat(2.0), max: CGFloat(4.0))
//        let balloonDirection    =
        
        let actionMove = SKAction.move(to: CGPoint(x: -balloonNode.size.width/2, y: startingY),
                                        duration: TimeInterval(balloonSpeed))
         let actionMoveDone = SKAction.removeFromParent()
         balloonNode.run(SKAction.sequence([actionMove, actionMoveDone]))
       }
    
    
//        playerSprite.zRotation = angle - 90
//    https://www.raywenderlich.com/5504-trigonometry-for-game-programming-spritekit-and-swift-tutorial-part-1-2

        
//        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
//
//        // Create the actions
//        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
//                                       duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
//      }
        
}

