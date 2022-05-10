//
//  Playing.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 9/5/2022.
//
//this is where the playing game play is

import SpriteKit
import GameplayKit

//global var
var chosenDuration = UserDefaults.standard.string(forKey: "balloonSeconds")
var chosenBalloonCount = UserDefaults.standard.string(forKey: "balloonNo")

class Playing: GKState {
    var balloonNodes = [Balloon]()
    //    var countDownTimerCounter = Int(chosenDuration!)!               //let's say it starts at 60
    var balloonsAdded = [SKSpriteNode]()
    var balloonStack = Stack()
    var player = Player(id: "test", name: "test")
    var timer = Timer()
    
    lazy var timerLabel: SKLabelNode = scene.childNode(withName: "timer") as! SKLabelNode
    lazy var scoreLabel: SKLabelNode = scene.childNode(withName: "score") as! SKLabelNode
    
    var score = Score(id: UUID().uuidString, username: "Samabababa", score: 0, time: 0)
    
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        scoreLabel.isHidden = false
        scene.gameTimer.startWithDuration(durationInSeconds: Double(chosenDuration!)! + 1)
        if previousState is ThreeSecondCountdown {
            //generating x number of balloons every 1 second of game play
            //create an array of x number of balloons
            //add them in random places on the view
            //start the timer
            //calculate the score
            
            
            let waitForOneSecond = SKAction.wait(forDuration: 1)
            
            let waitForTwoSecond = SKAction.wait(forDuration: 2)
            
            let spawnBalloonsAction = SKAction.run {
                self.addBalloonsToScene()
            }
            let removeBalloonsAction = SKAction.run {
                self.removeBalloonsFromScene()
            }
            
            scene.run(SKAction.repeatForever(
                SKAction.sequence([
                    spawnBalloonsAction,
                    waitForTwoSecond,
                    removeBalloonsAction,
                    waitForOneSecond
                ]))
            )
        }
    }
    
    
    func removeBalloonsFromScene() {
        for balloons in balloonNodes {
            balloons.removeFromParent()
            balloonNodes.removeAll()
        }
    }
    
    //create balloons and add them to the scene
    func addBalloonsToScene() {
        balloonNodes = generateBalloons()
        print("balloon node count is: \(balloonNodes.count)")
        for balloons in balloonNodes {
            scene.addChild(balloons)
        }
    }
    
    func createBalloon() -> SKNode<Balloon> {
        
    }
    
    func generateBalloons() -> Array<Balloon> {
        var balloonArr = [Balloon]()
        let chosenBalloonInt = Int(chosenBalloonCount!)
        let numberOfBalloonsToGenerate = randomInteger(min: 1, max: chosenBalloonInt!)//selects a number between 1 and the max to generate per second
        
        for index in 0...numberOfBalloonsToGenerate {
            print("number of balloons to gen: \(numberOfBalloonsToGenerate)")
            
            //create balloon, send the scene to measure the frame
            let balloon = Balloon(gameScene: scene)
            
            balloon.name = "balloon"
            
            
            balloonArr.append(balloon)
            
            print("balloons pos is\(balloon.position) and velocity is \(String(describing: balloon.physicsBody?.velocity))")
        }
        return balloonArr
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        //update timer and score
        
        scene.updateScore()
        
        scene.updateTimer()
        
    }
    
    
    
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOver.Type
    }
    
}


//update score
//update timer
//check balloons are moving



//check the balloons are travelling
//        let balloon = scene.children(withName: "balloon") as! SKSpriteNode
//        balloon.
//
//        enumerateChildNodes
//
//
//        let ball = scene.childNode(withName: BallCategoryName) as! SKSpriteNode
//        let maxSpeed: CGFloat = 400.0
//
//        let xSpeed = sqrt(ball.physicsBody!.velocity.dx * ball.physicsBody!.velocity.dx)
//        let ySpeed = sqrt(ball.physicsBody!.velocity.dy * ball.physicsBody!.velocity.dy)
//
//        let speed = sqrt(ball.physicsBody!.velocity.dx * ball.physicsBody!.velocity.dx + ball.physicsBody!.velocity.dy * ball.physicsBody!.velocity.dy)
//
//        if xSpeed <= 10.0 {
//          ball.physicsBody!.applyImpulse(CGVector(dx: randomDirection(), dy: 0.0))
//        }
//        if ySpeed <= 10.0 {
//          ball.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: randomDirection()))
//        }
//
//        if speed > maxSpeed {
//          ball.physicsBody!.linearDamping = 0.4
//        } else {
//          ball.physicsBody!.linearDamping = 0.0
//        }
//
//        <#code#>


