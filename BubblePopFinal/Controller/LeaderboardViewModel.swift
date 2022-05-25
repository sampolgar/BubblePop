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
    var newScore: Score
    
    init(newScore: Score){
        self.newScore = newScore
    }
    
    init(){
        newScore = Score(id: "", username: "", score: 0, time: 0)
    }
    
    func createScore() {
        
        let obj: [String: Any] = [
            "score": newScore.score,
            "time": newScore.time,
            "username": newScore.username
        ]

        let highestScoreRef = Database.database().reference().child("highestScores").child(UUID().uuidString).setValue(obj)
    }
    
    
    
    
    func getScore() {
        
        //get a ref to the database
        let ref = Database.database().reference().child("highestScores").queryOrdered(byChild: "score").queryLimited(toLast: 10)
        
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
                        
                        //order the list
                        self.list.sort(by: { $0.score > $1.score })
                        
                    }
                })
            }
        })
    }
    
}
