//
//  InitialViewController.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 25/5/2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func readyButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segoeToLogin", sender: self)
    }
    
}
