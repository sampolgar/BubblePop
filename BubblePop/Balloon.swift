//
//  Balloon.swift
//  BubblePop
//
//  Created by Samuel Polgar on 12/4/2022.
//
import SpriteKit

class Balloon: SKSpriteNode {
    var balloonColor: String?
    var gameScore: Int?
//    var balloonDirection: String
    
    init () {
        let balloonSize = CGSize(width: 50, height: 50)
        
        super.init(texture: nil, color: UIColor.clear, size: balloonSize)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setBalloonDirection(){
        
    }
    
    public func changeBalloonDirection(){
        
    }
    
    private func setup() {
        let randomInt = Int.random(in: 0..<100)
        switch randomInt
        {
        case 0..<40:
            self.balloonColor = "red"
            self.gameScore = 1
            self.texture = SKTexture(imageNamed: "redBalloon.png")
        case 40..<70:
            self.balloonColor = "pink"
            self.gameScore = 2
            self.texture = SKTexture(imageNamed: "pinkBalloon.png")
        case 70..<85:
            self.balloonColor = "green"
            self.gameScore = 5
            self.texture = SKTexture(imageNamed: "greenBalloon.png")
        case 85..<95:
            self.balloonColor = "blue"
            self.gameScore = 8
            self.texture = SKTexture(imageNamed: "blueBalloon.png")
        case 95..<100:
            self.balloonColor = "black"
            self.gameScore = 10
            self.texture = SKTexture(imageNamed: "blackBalloon.png")
        default:
            self.balloonColor = "nil"
            self.gameScore = 0
        }
    }
}
