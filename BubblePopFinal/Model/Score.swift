//
//  Score.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 3/5/2022.
//
import Foundation

class Score: Identifiable, ObservableObject {
    
    var id: String
    var score: Int
    var time: Int
    var username: String
    
    init(id: String, username: String, score: Int, time: Int) {
        self.id = id
        self.score = score
        self.time = time
        self.username = username
    }
}
