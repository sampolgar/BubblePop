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
    @IBOutlet weak var EnterPasswordLabel: UILabel!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad(){
        if(!defaults.bool(forKey: "name")) {
            //new user
            enterNameLabel.text = "Enter Name"
            EnterEmailLabel.text = "Enter Email"
            EnterPasswordLabel.text = "Enter Password"
            
        } else {
            //previous user
            enterNameLabel.text = "Welcome"
            EnterEmailLabel.text = ""
            EnterPasswordLabel.text = ""
            
            nameInput.text = defaults.string(forKey: "name")
            emailInput.text = defaults.string(forKey: "email")
        }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let name = nameInput.text
        let email = emailInput.text
        let password = passwordInput.text
        
        defaults.set(name, forKey: "name")
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
        
        performSegue(withIdentifier: "segueToTabBar", sender: self)
        
    }
}
