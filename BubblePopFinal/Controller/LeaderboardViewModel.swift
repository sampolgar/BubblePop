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
    
    func getData() {
        
        //get a ref to the database
        let ref = Database.database().reference().child("highestScores").queryOrdered(byChild: "score").queryLimited(toLast: 5)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            
            DispatchQueue.main.async {
                
                dictionary.forEach({(key, value) in
                    
                    if let resultsArray = value as? [String: Any] {
                        let id = key
                        let score = resultsArray["score"] as? Int
                        let time = resultsArray["time"] as? Int
                        let username = resultsArray["username"] as? String
                        let scoreObj = Score(id: id, username: username ?? "", score: score ?? 0, time: time ?? 0)
                        self.list.append(scoreObj)
                    }
                })
            }
        })
    }
    
}
