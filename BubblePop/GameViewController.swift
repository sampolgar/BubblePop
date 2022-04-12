//
//  GameViewController.swift
//  BubblePop
//
//  Created by Samuel Polgar on 12/4/2022.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    override func viewDidLoad(){
      super.viewDidLoad()
      print(" 1. my skview is \(self.view!)")
        let scene = GameScene(size: view.bounds.size)
        print(" 2. my skview is \(self.view!)")
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
}
