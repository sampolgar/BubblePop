//
//  GameScene.swift
//  BubblePop2
//
//  Created by Samuel Polgar on 13/4/2022.
//
//To do
// Make single balloon move and bounce from the walls
// Create 15 balloons

import SpriteKit

struct PhysicsCategory {
  static let none             : UInt32 = 0
  static let all              : UInt32 = UInt32.max
  static let balloon          : UInt32 = 0b1         // 1
  static let balloonPopper    : UInt32 = 0b10       //  2
}

class GameScene: SKScene {
  var balloonCount = 0
  var lastUpdateTime: CFTimeInterval = 0
  var sceneContent = false
  var balloonsAdded = [SKSpriteNode]()
  var balloonStack = Stack()
  var player = Player(name: "test")
  let timerLabel = CountDownClockLabel()
  let scoreLabel = SKLabelNode(fontNamed: "Arial")
  
  override func didMove(to view: SKView) {
    if (!self.sceneContent) {
          self.createSceneContents()
          self.sceneContent = true
        }
//    physicsWorld.contactDelegate = self
    physicsWorld.gravity = .zero
    createClock()
    createScore()
  }
  
  func createClock(){
    addChild(timerLabel)
    let clockPosition = CGPoint(x: frame.maxX, y: frame.maxY)
    print("clock position: \(clockPosition)")
    timerLabel.position = clockPosition
  }

  func createScore(){
    scoreLabel.text = String(player.score)
    scoreLabel.fontSize = 65
    scoreLabel.fontColor = SKColor.white
    scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
    addChild(scoreLabel)
  }
  
  func updateScore(){
    scoreLabel.text =  String(player.score)
  }
  
  override func sceneDidLoad() {
    setup15Ballons()
    timerLabel.startWithDuration(durationInSeconds: 60)
  }
  
  override func update(_ currentTime: TimeInterval) {
    
    if self.balloonCount < 15 {
      print("Creating balloon. balloon count: \(self.balloonCount)" )
      createBalloon()
      timerLabel.update()
      updateScore()
    }
  }
  
  func createSceneContents(){
    let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    borderBody.friction = 0
    self.physicsBody = borderBody
  }
  
  func createBalloon(){
    let balloon = Balloon()
    balloon.name = "balloon"
    
    //check if a balloon exists there already
    for currentBalloon in balloonsAdded {
      if (balloon.intersects(currentBalloon)){
        return
      }
    }
    
    balloonCount += 1
    addChild(balloon)
    balloonsAdded.append(balloon)
  }
  
  func setup15Ballons(){
    for _ in 1...15 {
        createBalloon()
    }
  }
  
  //check the user touched a balloon
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let touchLocation = touch.location(in: self)
    let touchedNodes = nodes(at: touchLocation)
    for node in touchedNodes {
      if let balloon = node as? Balloon {
        touchedBalloon(balloon: balloon)
      }
    }
  }
  
  func touchedBalloon(balloon: Balloon) {
    let currentBalloonColor = balloon.balloonColor
    print("colour: \(currentBalloonColor)")
    print("score: \(balloon.gameScore)")
    //update score
    
    //check if the last balloon added was the same color, if so, add double points
    if (!balloonStack.isEmpty()) {
      let lastPoppedBalloon = balloonStack.peek()
      if (lastPoppedBalloon.balloonColor == currentBalloonColor){
        player.score += balloon.gameScore!*1.5
      } else {
        player.score += balloon.gameScore!
      }
    } else {
      player.score += balloon.gameScore!
    }
    balloonStack.push(balloon)
    balloon.removeFromParent()
    balloonCount -= 1
  }
}
//  func pinPoppedBalloon(balloon: SKSpriteNode, balloonPopper: SKSpriteNode) {
//    print("collision! for \(balloon.attributeValues)")
//    balloon.removeFromParent()
//  }
//}

//extension GameScene: SKPhysicsContactDelegate {
//
//  func didBegin(_ contact: SKPhysicsContact) {
//    var body1: SKPhysicsBody
//    var body2: SKPhysicsBody
//
//    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//      body1 = contact.bodyA
//      body2 = contact.bodyB
//    } else {
//      body1 = contact.bodyB
//      body2 = contact.bodyA
//    }
//
//  if ((body1.categoryBitMask & PhysicsCategory.balloon != 0) && (body2.categoryBitMask & PhysicsCategory.balloonPopper != 0)){
//    if let balloon = body1.node as? SKSpriteNode, let balloonPopper = body2.node as? SKSpriteNode {
//      pinPoppedBalloon(balloon: balloon, balloonPopper: balloonPopper)
//    }
//  }
//}
//}
  
  
//    let balloonPopper = BalloonPopper()
//    addChild(balloonPopper)
//    balloonPopper.position = touchLocation
//
//    let scale = SKAction.scale(to: 0.5, duration: 0.1)
//    let fade = SKAction.fadeOut(withDuration: 0.1)
//    let done = SKAction.removeFromParent()
//    let sequence = SKAction.sequence([scale, fade, done])
//    balloonPopper.run(sequence)
