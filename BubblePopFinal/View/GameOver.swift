//
//  GameOver.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 3/5/2022.
//

import SpriteKit

class GameOver: SKScene {
    init(size: CGSize, score: Int, time: String) {
    super.init(size: size)
    
    backgroundColor = SKColor.white
      
      let results = "score: \(score) in time: \(time)"
    
    // 3
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = results
    label.fontSize = 40
    label.fontColor = SKColor.black
    label.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(label)
      
    
    // 4
    run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),
      SKAction.run() { [weak self] in
        // 5
        guard let `self` = self else { return }
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
      }
      ]))
   }
  
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
