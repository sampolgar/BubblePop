//
//  ScoreLabel.swift
//  BubblePop
//
//  Created by Samuel Polgar on 20/4/2022.
//
import SpriteKit
class Player {
    var score = 0.0
    var name: String
    
    init(name: String){
        self.name = name
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
