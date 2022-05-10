//
//  ThreeSecondCountdown.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 10/5/2022.
//
import SpriteKit
import GameplayKit

class ThreeSecondCountdown: GKState {
    
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.countDownTimer.startWithDuration(durationInSeconds: 4)
        
        let scale = SKAction.scale(to: 1.0, duration: 0.5)
        scene.childNode(withName: CountDownTimer)!.run(scale)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        scene.updateCountdownTimer()
        if scene.countDownTimer.hasFinished() {
            print("timer finished")
            scene.gameState.enter(Playing.self)
        }
    }
    
    override func willExit(to nextState: GKState) {
        if nextState is Playing {
            print("hello here moving to playing")
            scene.childNode(withName: CountDownTimer)?.removeFromParent()
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Playing.Type
    }
}
