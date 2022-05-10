//
//  GameOver.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 9/5/2022.
//
import SpriteKit
import GameplayKit

class GameOverStartAgain: GKState {
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        //send scores to the DB
        let scale = SKAction.scale(to: 1.0, duration: 0.5)
        scene.childNode(withName: GameEnded)!.run(scale)
        print("hererere")
    }
    
    override func willExit(to nextState: GKState) {
        scene.childNode(withName: CountDownTimer)?.removeFromParent()
        scene.childNode(withName: GameScore)?.removeFromParent()
        
        
        
        let wait = SKAction.wait(forDuration: 4)
        
        let sendToLeaderboard = SKAction.run { [self] in
            scene.segueToLeaderboard()
        }
        
        SKAction.run {
            SKAction.sequence([
                wait,
                sendToLeaderboard
            ])
        }
        
    }
    
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass is WaitForStart.Type
//    }
}
