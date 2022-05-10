//
//  LeaderBoardViewModel.swift
//  BubblePop
//
//  Created by Samuel Polgar on 1/5/2022.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseCore

class LeaderboardViewModel: ObservableObject {
    
    @Published var list = [Score]()
    
    func createScore(newScore: Score){
        print("creating score with")
        let scoreId = newScore.id
        let username = newScore.username
        let score = newScore.score
        let time = newScore.time
        let ref = Database.database().reference().child("highestScores").child(scoreId).setValue([
            "score": score,
            "time": time,
            "username": username
        ])
    }
    
    func getScore() {
        
        //get a ref to the database
        let ref = Database.database().reference().child("highestScores").queryOrdered(byChild: "score").queryLimited(toLast: 5)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            
            DispatchQueue.main.async {
                
                dictionary.forEach({(key, value) in
                    
                    if let resultsArray = value as? [String: Any] {
                        print(key)
                        let id = key
                        let score = resultsArray["score"] as? Int
                        let time = resultsArray["time"] as? Int
                        let username = resultsArray["username"] as? String
                        let scoreObj = Score(id: id, username: username!, score: score!, time: time!)
                        self.list.append(scoreObj)
                    }
                })
            }
        })
    }
    
}
