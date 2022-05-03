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
    var gameIsOver = false;
    var balloonCount = 0
    var lastUpdateTime: CFTimeInterval = 0
    var sceneContent = false
    var balloonsAdded = [SKSpriteNode]()
    var balloonStack = Stack()
    //    var player = Player(name: "test")
    var player = Player(id: "test", name: "test")
    var timer = Timer()
    lazy var timerLabel: SKLabelNode = self.childNode(withName: "timer") as! SKLabelNode
    lazy var scoreLabel: SKLabelNode = self.childNode(withName: "score") as! SKLabelNode
    var chosenDuration = UserDefaults.standard.string(forKey: "balloonSeconds")
    var chosenBalloonCount = UserDefaults.standard.string(forKey: "balloonNo")
    var score = Score(score: 0, time: 0)
    //    var score = Score(player: player, score: 0, time: 0)
    
    //testing
    //  var entities = [GKEntity]()
    //    var graphs = [String : GKGraph]()
    
    override func didMove(to view: SKView) {
        
        
        if (!self.sceneContent) {
            self.createSceneContents()
            self.sceneContent = true
        }
        physicsWorld.gravity = .zero
    }
    
    func updateScore(){
        //        scoreLabel.text = String(player.score)
        scoreLabel.text = String(score.score)
    }
    
    override func sceneDidLoad() {
        timer.startWithDuration(durationInSeconds: Double(chosenDuration!)!)
        timerLabel.text = timer.text
        scoreLabel.text = String(score.score)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if !gameIsOver {
            if balloonCount != Int(chosenBalloonCount!)! {
                let x = self.balloonCount
                
                let newBalloonsMax = Int(chosenBalloonCount!)! - x    //e,g number 5
                
                let randomInt = Int.random(in: 0..<newBalloonsMax)
                
                for _ in 0...randomInt {
                    createBalloon()
                }
            }
            
            updateTimer()
            updateScore()
            
        }
        
    }
    
    func updateTimer(){
        timer.update()
        if Int(timer.text!) == 0 {
            gameOver()
        }
        timerLabel.text = timer.text
    }
    
    func createSceneContents(){
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
    }
    
    func gameOver(){
        let gameOverScene = GameOver(size: self.size, score: self.score.score, time: self.chosenDuration ?? "60")
        gameOverScene.scaleMode = .aspectFit
        self.view?.presentScene(gameOverScene, transition: SKTransition.fade(withDuration: 1))
    }

func createBalloon(){
    let currentBalloon = Balloon()
    print("balloons pos is\(currentBalloon.position)")
    currentBalloon.name = "balloon"
    balloonCount += 1
    addChild(currentBalloon)
    //
    //        //check if a balloon exists in the same position already
    //        for balloons in balloonsAdded {
    //            if (currentBalloon.intersects(balloons)){
    //                return
    //            }
    //            else {
    //                print("doesn't intersect")
    //            }
    //        }
    
    
    //        balloonsAdded.append(currentBalloon)
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
            score.score += Int(balloon.gameScore!*1.5)
        } else {
            score.score += Int(balloon.gameScore!)
        }
    } else {
        score.score += Int(balloon.gameScore!)
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
