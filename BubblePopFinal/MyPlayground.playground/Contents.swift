//import Foundation
//import Firebase
//import FirebaseCore
//import FirebaseAnalytics
//import FirebaseDatabase
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

