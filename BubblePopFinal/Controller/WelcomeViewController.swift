//
//  WelcomeViewController.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func tabBarButtonPressed(_ sender: Any) {
        print("tab pressed")
        performSegue(withIdentifier: "segueToTabBar", sender: self)
    }
    
    @IBAction func gameButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueStartGame", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
