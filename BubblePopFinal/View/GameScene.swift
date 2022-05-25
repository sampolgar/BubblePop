//
//  GameScene.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//
//
import Foundation
import SpriteKit
import GameplayKit

let GameMessageName = "gameMessage"
let CountDownMessageName = "countdownMessage"
var start3SecondCountDown = 4
let GameTimer = "gameTimer"
let CountDownTimer = "countDownTimer"
let GameScore = "score"
let GameEnded = "gameEnded"
let GameOverScore = "gameOverScore"
let Chalkduster = "Chalkduster"
let leaderboardViewModel = LeaderboardViewModel()


struct PhysicsCategory {
    static let none             : UInt32 = 0
    static let all              : UInt32 = UInt32.max
    static let balloon          : UInt32 = 0b1         // 1
    static let balloonPopper    : UInt32 = 0b10       //  2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    lazy var gameState: GKStateMachine = GKStateMachine(states: [
        WaitForStart(scene: self),
        ThreeSecondCountdown(scene: self),
        Playing(scene: self),
        GameOverStartAgain(scene: self)
    ])
    
    var lastUpdateTime: CFTimeInterval = 0
    //    var balloonsAdded = [SKSpriteNode]()
    var balloonStack = Stack()
    var player = Player(id: "test", name: "test")
    
    //create the game timer e.g. counting down from 60 seconds
    var gameTimer = Timer()
    lazy var gameTimerLabel: SKLabelNode = self.childNode(withName: GameTimer) as! SKLabelNode
    
    //create the 3 2 1 count down timer on the front screen
    var countDownTimer = Timer()
    lazy var countDownLabel: SKLabelNode = self.childNode(withName: CountDownTimer) as! SKLabelNode

    
    //create the score
    lazy var scoreLabel: SKLabelNode = self.childNode(withName: GameScore) as! SKLabelNode
    
    var chosenDuration = UserDefaults.standard.string(forKey: "balloonSeconds")
    var chosenBalloonCount = UserDefaults.standard.string(forKey: "balloonNo")
    var currentScore = Score(id: UUID().uuidString, username: "Samabababa", score: 0, time: 0)
    
    //set the scene
    override func didMove(to view: SKView) {
        
        //create the scene
        setTheScene()
        
        //set count down timer
        gameTimerLabel.fontName = Chalkduster
        gameTimerLabel.text = gameTimer.text
        
        //set coundDownTimer
        countDownLabel.fontName = Chalkduster
        countDownLabel.fontSize = 65
        countDownLabel.text = countDownTimer.text
        
        //set balloon score
        scoreLabel.fontName = Chalkduster
        scoreLabel.text = String(currentScore.score)
        
        //create play message
        let gameMessage = SKLabelNode(fontNamed: "Chalkduster")
        gameMessage.name = GameMessageName
        gameMessage.text = "Ready? Tap!"
        gameMessage.fontSize = 65
        gameMessage.fontColor = SKColor.white
        gameMessage.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameMessage)
        
        
        gameTimer.startWithDuration(durationInSeconds: 100.00)
        
        countDownTimer.startWithDuration(durationInSeconds: 100.00)
        
        gameState.enter(WaitForStart.self)
    }
    
    func createGameOverMessage(){
        let gameEnded = SKLabelNode(fontNamed: "Chalkduster")
        gameEnded.name = GameEnded
        gameEnded.text = "Congrats! Tap for settings"
        gameEnded.fontSize = 40
        gameEnded.fontColor = SKColor.white
        gameEnded.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameEnded)
    }
    
    func createGameOverScore(){
        let gameOverScore = SKLabelNode(fontNamed: "Chalkduster")
        gameOverScore.name = GameOverScore
        gameOverScore.text = "Score: \(currentScore.score) in: \(chosenDuration!) seconds"
        gameOverScore.fontSize = 40
        gameOverScore.fontColor = SKColor.white
        gameOverScore.position = CGPoint(x: frame.midX, y: frame.midY-100)
        addChild(gameOverScore)
    }
    
    func addScoresToLeaderboard(){
//        UserDefaults.standard.set(user.displayName, forKey: "userDisplayName")
//        UserDefaults.standard.set(user.email, forKey: "userEmail")
        let username = UserDefaults.standard.string(forKey: "userDisplayName") ?? ""
        print("creating score: ")
        
        let newScore = Score(id: "", username: username, score: currentScore.score, time: Int(chosenDuration!) ?? 60)
        LeaderboardViewModel(newScore: newScore).createScore()
    }
    
    //setting the scene
    func setTheScene(){
        //set general physics body
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        borderBody.restitution = 1
        borderBody.linearDamping = 0
        borderBody.angularDamping = 0
        self.physicsBody = borderBody
        
        //setup physics world
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        //create bottom bounce
        let bottomOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomOfScreen)
        addChild(bottom)
        bottom.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        //create top bounce
        let topOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - 1)
        let top = SKNode()
        top.physicsBody = SKPhysicsBody(edgeLoopFrom: topOfScreen)
        addChild(top)
        top.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        //create left bounce
        let leftOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: 1, height: frame.size.height)
        let left = SKNode()
        left.physicsBody = SKPhysicsBody(edgeLoopFrom: leftOfScreen)
        addChild(left)
        left.physicsBody!.categoryBitMask = PhysicsCategory.all
        
        //create right bounce
        let rightOfScreen = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width - 1, height: frame.size.height)
        let right = SKNode()
        right.physicsBody = SKPhysicsBody(edgeLoopFrom: rightOfScreen)
        addChild(right)
        right.physicsBody!.categoryBitMask = PhysicsCategory.all
    }
    
    //when the scene loads, set the timer label and score labels
    override func sceneDidLoad() {
        //nothing
    }
    
    //update timer based on countdown
    func updateTimer(){
        gameTimer.update()
        gameTimerLabel.text = gameTimer.text
    }
    
    func updateCountdownTimer(){
        countDownTimer.update()
        countDownLabel.text = countDownTimer.text
    }
    
    //update score based on current score
    func updateScore(){
        scoreLabel.text = String(currentScore.score)
    }
    
    override func update(_ currentTime: TimeInterval) {
        //check the current state
        gameState.update(deltaTime: currentTime)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState.currentState {
            
        case is WaitForStart:
            print("touched waiting for start")
            gameState.enter(ThreeSecondCountdown.self)

        case is Playing:
            guard let touch = touches.first else { return }
            let touchLocation = touch.location(in: self)
            let touchedNodes = nodes(at: touchLocation)
            for node in touchedNodes {
                if let balloon = node as? Balloon {
                    touchedBalloon(balloon: balloon)
                }
            }

        case is GameOverStartAgain:
            segueToLeaderboard()
            
        default:
            break
        }
    }
        
        //check the user touched a balloon
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        }
        
        func touchedBalloon(balloon: Balloon) {
            let currentBalloonColor = balloon.balloonColor
            //check if the last balloon added was the same color, if so, add 1.5x points
            if (!balloonStack.isEmpty()) {
                let lastPoppedBalloon = balloonStack.peek()
                if (lastPoppedBalloon.balloonColor == currentBalloonColor){
                    currentScore.score += Int(balloon.gameScore!*1.5)
                } else {
                    currentScore.score += Int(balloon.gameScore!)
                }
            } else {
                currentScore.score += Int(balloon.gameScore!)
            }
            balloonStack.push(balloon)
            balloon.removeFromParent()
        }
    
    func createNewScore(){
        print("creating current score")
    }
    
    func segueToLeaderboard(){
        let tabViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")
        UIApplication.topViewController()?.present(tabViewController, animated: true, completion: nil)
        
     }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
