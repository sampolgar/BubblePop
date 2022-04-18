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
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let balloon   : UInt32 = 0b1       // 1
}

class GameScene: SKScene {
  var balloonCount = 0
  var lastUpdateTime: CFTimeInterval = 0
  var sceneContent = false
  
  override func didMove(to view: SKView) {
    if (!self.sceneContent) {
          self.createSceneContents()
          self.sceneContent = true
        }
    physicsWorld.contactDelegate = self
    physicsWorld.gravity = .zero
  }
  
  override func sceneDidLoad() {
    setup15Ballons()
  }
  
  override func update(_ currentTime: TimeInterval) {
  }
  
  //check the user touched a balloon
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let touchLocation = touch.location(in: self)
    let touchSize = CGSize(width: 25,height: 25)
    let touchNode = SKSpriteNode(color: SKColor.white, size: touchSize)
    
    touchNode.physicsBody = SKPhysicsBody(circleOfRadius: 12.5)
    addChild(touchNode)
    touchNode.position = touchLocation
  }
  
  func createSceneContents(){
    let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    borderBody.friction = 0
    self.physicsBody = borderBody
  }
  
  func createBalloon(){
    let balloon = Balloon()
    balloon.name = "balloon"
    balloonCount += 1
    addChild(balloon)
  }
  
  func setup15Ballons(){
    for _ in 1...15 {
        createBalloon()
    }
  }
}

extension GameScene: SKPhysicsContactDelegate {

}





