//
//  GameScene.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var balloonCount = 0
    var lastUpdateTime: CFTimeInterval = 0
    var sceneContent = false
    var balloonsAdded = [SKSpriteNode]()
    var balloonStack = Stack()
    var player = Player(name: "test")
    var timer = Timer()
    lazy var timerLabel: SKLabelNode = self.childNode(withName: "timer") as! SKLabelNode
    lazy var scoreLabel: SKLabelNode = self.childNode(withName: "score") as! SKLabelNode
    
    
    //testing
    //  var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    override func didMove(to view: SKView) {
        if (!self.sceneContent) {
            self.createSceneContents()
            self.sceneContent = true
        }
        physicsWorld.gravity = .zero
    }
    
    func updateScore(){
        scoreLabel.text = String(player.score)
    }
    
    override func sceneDidLoad() {
        
        //    self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //    if let label = self.label {
        //      label.text = "hello beautiful"
        //      print("Hello    \(self.label!.text)")
        //        label.alpha = 0.0
        //        label.run(SKAction.fadeIn(withDuration: 2.0))
        //    }
        
        timerLabel.text = timer.text
        scoreLabel.text = String(player.score)
        
        
        timer.startWithDuration(durationInSeconds: 60)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.balloonCount < 15 {
            createBalloon()
        }
        
        updateTimer()
        updateScore()
    }
    
    func updateTimer(){
        timer.update()
        timerLabel.text = timer.text
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















//import SpriteKit
//import GameplayKit
//
//class GameScene: SKScene {
//
//    var entities = [GKEntity]()
//    var graphs = [String : GKGraph]()
//
//    private var lastUpdateTime : TimeInterval = 0
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//
//    override func sceneDidLoad() {
//
//        self.lastUpdateTime = 0
//
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
//    }
//
//
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//
//        // Initialize _lastUpdateTime if it has not already been
//        if (self.lastUpdateTime == 0) {
//            self.lastUpdateTime = currentTime
//        }
//
//        // Calculate time since last update
//        let dt = currentTime - self.lastUpdateTime
//
//        // Update entities
//        for entity in self.entities {
//            entity.update(deltaTime: dt)
//        }
//
//        self.lastUpdateTime = currentTime
//    }
//}
