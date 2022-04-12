//
//  GameViewController.swift
//  BubblePop
//
//  Created by Samuel Polgar on 12/4/2022.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      let scene = GameScene(size: view.bounds.size)
      let skView = view as! SKView
      scene.scaleMode = .resizeFill
      
      //optional scene choices
//      skView.showsFPS = true
//      skView.showsNodeCount = true
//      skView.ignoresSiblingOrder = true
      
      skView.presentScene(scene)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
