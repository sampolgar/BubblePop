//
//  LeaderboardViewController.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 6/5/2022.
//
import Foundation
import UIKit
import SwiftUI

class LeaderboardViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        
    }
    //let the leadeboard display
    @IBOutlet var leaderboardContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leaderboardView = LeaderboardView()
        
        let childView = UIHostingController(rootView: leaderboardView)
        addChild(childView)
        
        childView.view.frame = leaderboardContainer.bounds
        
        leaderboardContainer.addSubview(childView.view)
        
        childView.didMove(toParent: self)
    }
}
