//
//  SettingsViewController.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//

//import UIKit
import SwiftUI
import SpriteKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var settingsContainer: SKView!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.selectedIndex = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let allSettingsView = AllSettingsView()
        
        let childView = UIHostingController(rootView: allSettingsView)
        addChild(childView)
        
        childView.view.frame = settingsContainer.bounds
        
        settingsContainer.addSubview(childView.view)
        
        childView.didMove(toParent: self)
        
        // Do any additional setup after loading the view.
    }
    
    func viewWillDisappear() {
    }
}
