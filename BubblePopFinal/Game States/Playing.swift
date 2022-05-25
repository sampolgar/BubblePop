//
//  Playing.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 9/5/2022.
//
//this is where the playing game play is

import SpriteKit
import GameplayKit
let displaySize: CGRect = UIScreen.main.bounds

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
    
    func generateBalloons() -> Array<Balloon> {
        var balloonArr = [Balloon]()
        let chosenBalloonInt = Int(chosenBalloonCount!)
        let numberOfBalloonsToGenerate = randomInteger(min: 1, max: chosenBalloonInt!)//selects a number between 1 and the max to generate per second
        
        for index in 0...numberOfBalloonsToGenerate {
            print("number of balloons to gen: \(numberOfBalloonsToGenerate)")
            
            //create balloon, send the scene to measure the frame
            let balloon = Balloon(gameScene: scene)
            
            balloon.name = "balloon"
            
            let physicsBalloon = giveBalloonPhysics(balloon: balloon)
            
            balloonArr.append(physicsBalloon)
            
            print("balloons pos is\(physicsBalloon.position) and velocity is \(String(describing: physicsBalloon.physicsBody?.velocity))")
        }
        return balloonArr
    }
    
    func giveBalloonPhysics(balloon: Balloon) -> Balloon {
        
        let defaultImage = SKTexture(imageNamed: "pinkBalloon.png")
        balloon.physicsBody = SKPhysicsBody(circleOfRadius: balloon.size.height)
        balloon.physicsBody = SKPhysicsBody(texture: balloon.texture ?? defaultImage, size: balloon.size)
        //set random x and y coordinates
        
        //set random velocities
        let velocityX = random(min: -200, max: 100)
        let velocityY = random(min: -250, max: 250)
        //set random impulse
        let impulseX = random(min: -5, max: 5)
        let impulseY = random(min: -5, max: 5)
        
        
        balloon.physicsBody?.friction = 0
        balloon.physicsBody?.restitution = 1
        balloon.physicsBody?.angularDamping = 0
        balloon.physicsBody?.linearDamping = 0
        balloon.physicsBody?.angularDamping = 0
        balloon.physicsBody?.isDynamic = true
        
        //set starting velocity
        balloon.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
        balloon.physicsBody!.applyImpulse(CGVector(dx: impulseX, dy: impulseY))
        
        /*
         categoryBitMask - number defining the type of object this is for considering collisions
         collisionBitMask - number defining what categories of object this node should collide with
         contactTestBitMask - number defining which collisions we want to be notified about
         */
        balloon.physicsBody?.categoryBitMask = PhysicsCategory.balloon
        balloon.physicsBody?.collisionBitMask = PhysicsCategory.all
        print(balloon)
        print("here in physics")
        
        let randomDigit = arc4random() % 4 +  1
        var position = CGPoint()
        
        
        switch(randomDigit) {
        case 1: position = randomPointBetween(start: CGPoint(x: 0, y: displaySize.height), end: CGPoint(x: displaySize.width, y: displaySize.height))
        case 2: position = randomPointBetween(start: CGPoint(x: 0, y: 0), end: CGPoint(x: displaySize.width, y: 0))
        case 3: position = randomPointBetween(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: displaySize.height))
        case 4: position = randomPointBetween(start: CGPoint(x: displaySize.width, y: 0), end: CGPoint(x: displaySize.width, y: displaySize.height))
        default:
            break
        }

        print("position is \(position)")
        balloon.position =  position              // create the balloon on random x/y
        
        return balloon
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        //update timer and score
        
        scene.updateScore()
        
        scene.updateTimer()
        
        if scene.gameTimer.hasFinished() {
            scene.gameState.enter(GameOverStartAgain.self)
        }
    }
    
    
    
    
    override func willExit(to nextState: GKState) {
        //delete nodes
        //remove the actions
        scene.gameTimer
        print("score label is: \(scoreLabel.isHidden)")
        scoreLabel.isHidden = true
        print("score label is now: \(scoreLabel.isHidden)")
        scene.scoreLabel.isHidden = true
        scene.childNode(withName: "score")?.removeFromParent()
        
        
        self.scene.removeAllActions()
        removeBalloonsFromScene()
        scene.childNode(withName: GameTimer)?.removeFromParent()
        scene.childNode(withName: CountDownTimer)?.removeFromParent()
        scene.childNode(withName: GameScore)?.removeFromParent()
       
        
    }

override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is GameOverStartAgain.Type
}
}

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func randomPointBetween(start: CGPoint, end: CGPoint)->CGPoint{
    return CGPoint(x: randomBetweenNumbers(firstNum: start.x, secondNum: end.x), y: randomBetweenNumbers(firstNum: start.y, secondNum: end.y))
}
