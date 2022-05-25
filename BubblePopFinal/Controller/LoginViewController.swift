//
//  LoginViewController.swift
//  testgame2
//
//  Created by Samuel Polgar on 3/5/2022.
//

import SpriteKit
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
import FirebaseEmailAuthUI
import FirebaseAnalytics
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController, FUIAuthDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    let user: FIRUser? = Auth.auth().currentUser
    
    @IBAction func loginButtonPress(_ sender: Any) {
        print("login button tapped")
        
        
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        
        authUI.delegate = self
        
        let googleAuthProvider = FUIGoogleAuth(authUI: authUI)
        let authProviders: [FUIAuthProvider] = [
            googleAuthProvider,
            FUIEmailAuth()
        ]
        
        authUI.providers = authProviders
        
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
            
            if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
                return true
            }
            return false
        }
        
        let authViewController = authUI.authViewController()
        print("The authviewcontrollers loading: \(authViewController)")
        self.present(authViewController, animated: true) //send the user to the firebase auth
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error Signing In \(error.localizedDescription)")
            return
        }
        print("handle user and signup")
        
        guard let user = authDataResult?.user else { return }
        
        UserDefaults.standard.set(user.displayName, forKey: "userDisplayName")
        UserDefaults.standard.set(user.email, forKey: "userEmail")
        
        self.performSegue(withIdentifier: "segueToTabBar", sender: self)
        
    }
    
}
