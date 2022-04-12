//
//  GameScene.swift
//  BubblePop2
//
//  Created by Samuel Polgar on 13/4/2022.
//
import SpriteKit

class GameScene: SKScene {
    let gameBalloon: Balloon
    
    // Init
    
    override init(size: CGSize) {
        gameBalloon = Balloon()
        
        super.init(size: size)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setup() {
        addChild(gameBalloon)
        gameBalloon.position.x = size.width / 2
        gameBalloon.position.y = size.height / 2
    }
    
}
