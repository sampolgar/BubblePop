//
//  Stack.swift
//  BubblePop
//
//  Created by Samuel Polgar on 18/4/2022.
//
import Foundation

struct Stack {
    var balloonNodes: [Balloon] = []
    
    func isEmpty() -> Bool {
        if balloonNodes.isEmpty {
            return true
        }
        return false
    }
    
    mutating func push(_ balNode: Balloon){
        balloonNodes.insert(balNode, at: 0)
    }
    
    mutating func pop(){
        balloonNodes.removeFirst()
    }
    
    func peek() -> Balloon{
        guard let topElement = balloonNodes.first else { fatalError("This stack is empty") }
        return topElement
    }
}
