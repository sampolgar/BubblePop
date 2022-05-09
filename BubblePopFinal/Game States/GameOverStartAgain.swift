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
        
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is WaitForStart.Type
    }
    
}
