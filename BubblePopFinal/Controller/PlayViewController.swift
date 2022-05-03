//
//  StartViewController.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//

//import UIKit
import SpriteKit

class PlayViewController: UIViewController {

    @IBOutlet weak var balloonNo: UITextField!
    @IBOutlet weak var balloonSeconds: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.selectedIndex = 1
        print("balloonNo is \(UserDefaults.standard.string(forKey: "balloonNo"))")
        print("balloonSeconds is \(UserDefaults.standard.string(forKey: "balloonSeconds"))")
        balloonNo.text = UserDefaults.standard.string(forKey: "balloonNo")
        balloonSeconds.text = UserDefaults.standard.string(forKey: "balloonSeconds")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.setTitle("", for: .normal)
        let startButtonImage = UIImage(named: "start-button.png")
        startButton.setImage(startButtonImage, for: .normal)
        startButton.imageView?.contentMode = .scaleAspectFit

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startButtonTapped(_ sender: Any) {
        print(" 3 - 2 - 1 countdown")
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
