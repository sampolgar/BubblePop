//
//  SendToLeaderboard.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 11/5/2022.
//
import SpriteKit
import GameplayKit

class SendToLeaderboard: GKState {
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        //send scores to the DB
        scene.view.segueToLeaderboard()
    }
    
    override func willExit(to nextState: GKState) {
        scene.childNode(withName: CountDownTimer)?.removeFromParent()
        scene.childNode(withName: GameScore)?.removeFromParent()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is WaitForStart.Type
    }
}
