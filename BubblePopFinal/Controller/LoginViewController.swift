//
//  LoginViewController.swift
//  testgame2
//
//  Created by Samuel Polgar on 3/5/2022.
//

import SpriteKit

class LoginViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    @IBOutlet weak var enterNameLabel: UILabel!
    @IBOutlet weak var EnterEmailLabel: UILabel!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad(){
        if(!defaults.bool(forKey: "name")) {
            //new user
            enterNameLabel.text = "Enter Name"
            EnterEmailLabel.text = "Enter Email"
            
        } else {
            //previous user
            enterNameLabel.text = "Welcome"
            EnterEmailLabel.text = ""
            
            nameInput.text = defaults.string(forKey: "name")
            emailInput.text = defaults.string(forKey: "email")
        }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let name = nameInput.text
        let email = emailInput.text
        
        defaults.set(name, forKey: "name")
        defaults.set(email, forKey: "email")
        
        performSegue(withIdentifier: "segueToTabBar", sender: self)
    }
}
