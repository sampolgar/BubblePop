//
//  GameScene.swift
//  BubblePop2
//
//  Created by Samuel Polgar on 13/4/2022.
//
import SpriteKit
import GameplayKit

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
  var timer = Timer()
  let scoreLabel = SKLabelNode(fontNamed: "Arial")
  
  //testing
//  var entities = [GKEntity]()
  var graphs = [String : GKGraph]()
  
  override func didMove(to view: SKView) {
    if (!self.sceneContent) {
          self.createSceneContents()
          self.sceneContent = true
        }
//    physicsWorld.contactDelegate = self
    physicsWorld.gravity = .zero
    
    // Setup timer
    if let timer = childNode(withName: "timer") as? Timer {
      self.timer = timer
    }
    
    createScore()
  }

  func createScore(){
    scoreLabel.text = String(player.score)
    scoreLabel.fontSize = 65
    scoreLabel.fontColor = SKColor.white
    scoreLabel.position = CGPoint(x:self.size.width, y:self.size.height)
    scoreLabel.horizontalAlignmentMode = .right
    addChild(scoreLabel)
  }
  
  func updateScore(){
    scoreLabel.text = String(player.score)
  }
  
  override func sceneDidLoad() {
    timer.startWithDuration(durationInSeconds: 60)
  }
  
  override func update(_ currentTime: TimeInterval) {
    
    if self.balloonCount < 15 {
      print("Creating balloon. balloon count: \(self.balloonCount)" )
      createBalloon()
    }
    
    timer.update()
    
    updateScore()
  }
  
  func createSceneContents(){
    let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    borderBody.friction = 0
    self.physicsBody = borderBody
  }
  
  func createBalloon(){
    let balloon = Balloon()
    balloon.name = "balloon"
    
    //check if a balloon exists in the same position already
    for currentBalloon in balloonsAdded {
      if (balloon.intersects(currentBalloon)){
        return
      }
    }
    
    balloonCount += 1
    addChild(balloon)
    balloonsAdded.append(balloon)
  }
  
//  func setup15Ballons(){
//    for _ in 1...15 {
//        createBalloon()
//    }
//  }
//
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
    //check if the last balloon added was the same color, if so, add 1.5x points
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
