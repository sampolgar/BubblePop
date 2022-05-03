//
//  Score.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 3/5/2022.
//
import Foundation

class Score: Identifiable, ObservableObject {
    
    var defaults = UserDefaults.standard
    
    var id: String
    var score: Int
    var time: Int
    var name: String
    
    init(score: Int, time: Int) {
        self.id = defaults.string(forKey: "email") ?? "id"
        self.score = score
        self.time = time
        self.name = defaults.string(forKey: "name") ?? "name"
    }
}
