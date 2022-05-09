//
//  Playing.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 9/5/2022.
//
//this is where the playing game play is

import SpriteKit
import GameplayKit

class Playing: GKState {
    var balloonsAdded = [SKSpriteNode]()
    var balloonStack = Stack()
    var player = Player(id: "test", name: "test")
    var timer = Timer()
    lazy var timerLabel: SKLabelNode = scene.childNode(withName: "timer") as! SKLabelNode
    lazy var scoreLabel: SKLabelNode = scene.childNode(withName: "score") as! SKLabelNode
    var chosenDuration = UserDefaults.standard.string(forKey: "balloonSeconds")
    var chosenBalloonCount = UserDefaults.standard.string(forKey: "balloonNo")
    var score = Score(id: UUID().uuidString, username: "Samabababa", score: 0, time: 0)
    
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is WaitForStart {
            //create Scene
            createSceneContents()
            
            //create x number of balloons
            var balloonNodes[Balloon] = generateBalloons()
            
            //add balloons with function that removes them every second
            let wait = SKAction.wait(forDuration: 1)
            let createBalloons = SKAction.run {
                
                }
            }
            
            //add score label
            
            //add timer label
            
        }
    }
    
    func generateBalloons() -> [Balloon] {
        var balloonArr = [Balloon]()
        let chosenBalloonInt = Int(chosenBalloonCount!)
        let numberOfBalloonsToGenerate = randomInteger(min: <#T##Int#>, max: <#T##Int#>)//selects a number between 1 and the max to generate per second
        for index in 1...numberOfBalloonsToGenerate {
            let balloon = Balloon()
            balloon.name = "balloon"
            balloonArr.append(balloon)
            print("balloons pos is\(balloon.position) and velocity is \(String(describing: balloon.physicsBody?.velocity))")
            
            
        }
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        
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
    }
    
    func createSceneContents(){
        let bottomOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomOfScreen)
        addChild(bottom)
        bottom.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        let topOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - 1)
        let top = SKNode()
        top.physicsBody = SKPhysicsBody(edgeLoopFrom: topOfScreen)
        addChild(top)
        top.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        let leftOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: 1, height: frame.size.height)
        let left = SKNode()
        left.physicsBody = SKPhysicsBody(edgeLoopFrom: leftOfScreen)
        addChild(left)
        left.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        let rightOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width - 1, height: frame.size.height)
        let right = SKNode()
        right.physicsBody = SKPhysicsBody(edgeLoopFrom: rightOfScreen)
        addChild(right)
        right.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        self.physicsBody?.restitution = 1
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
    }
    
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOver.Type
    }
    
}
