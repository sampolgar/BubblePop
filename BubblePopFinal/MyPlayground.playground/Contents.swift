import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn

FirebaseApp.configure()

//print("hello")
////
//let ref = Database.database().reference()
//print(ref)
//ref.child("users").child("31a3d006-2c1b-4154-a4fc-ea6948cacc2d").setValue(["username": "sampolgarc"])
//print("done")
//

//func getData() {

var list = [Score]()
    
    //get a ref to the database
    let ref = Database.database().reference().child("highestScores").queryOrdered(byChild: "score").queryLimited(toLast: 5)
    
    ref.observeSingleEvent(of: .value, with: {(snapshot) in
        guard let dictionary = snapshot.value as? [String:Any] else {return}
        
        DispatchQueue.main.async {
            
            dictionary.forEach({(key, value) in
                
                if let resultsArray = value as? [String: Any] {
                    let id = key
//                    print("id is \(id)")
                    let score = resultsArray["score"] as? Int
//                    print("score is \(score)")
                    let time = resultsArray["time"] as? Int
//                    print("score is \(time)")
                    let username = resultsArray["username"] as? String
                    let scoreObj = Score(id: id, username: username ?? "", score: score ?? 0, time: time ?? 0)
                    list.append(scoreObj)
                }
            })
        }
        for score in list {
            print("hello i \(score.username)")
        }
    })
//}




//ref.child("users").setValue(["username": "sampolga"])


//
//FirebaseApp.configure()
//
//
//let ref = Database.database().reference()
//print(ref)
//ref.child("users").setValue(["username": "sampolga"])


//let ref = Database.database().reference().child("highestScores").queryOrdered(byChild: "score").queryLimited(toLast: 5)

//ref.child("users").child("email").observeSingleEvent(of: .value, with: { snapshot in
//  // Get user value
//  let value = snapshot.value as? NSDictionary
//  let username = value?["username"] as? String ?? ""
//  let user = User(username: username)
//
//  // ...
//}) { error in
//  print(error.localizedDescription)
//}
//
//
//
//func checkForUser(email: String) {
//    ref.child("users/\(email)/password").getData(completion:  { error, snapshot in
//      guard error == nil else {
//        print(error!.localizedDescription)
//        return;
//      }
//      let password = snapshot.value as? String ?? "Unknown";
//    });
//}
//
//checkForUser(email: "sampolgar@gmail.com")


//ref.child("users").child(user.uid).setValue(["username": "sampolga"])

