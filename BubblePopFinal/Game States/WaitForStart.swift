//
//  WaitForStart.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 9/5/2022.
//

import SpriteKit
import GameplayKit

class WaitForStart: GKState {
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        let scale = SKAction.scale(to: 1.0, duration: 0.5)
        scene.childNode(withName: GameMessageName)!.run(scale)
    }
    
    override func willExit(to nextState: GKState) {
        if nextState is ThreeSecondCountdown {
            let scale = SKAction.scale(to: 0, duration: 0.5)
            scene.childNode(withName: GameMessageName)!.run(scale)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is ThreeSecondCountdown.Type
    }
}
