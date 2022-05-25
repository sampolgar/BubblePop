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
//        GameScene.GameScore.

        scene.createGameOverMessage()
        scene.createGameOverScore()
        scene.addScoresToLeaderboard()
    }
    
    override func willExit(to nextState: GKState) {
        
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
}
