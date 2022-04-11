import UIKit
import Foundation

class Balloon
{
    var color: String?
    var gameScore: Int?
    
    
    //initializer
    
    //colour enum
    init(){
        chooseColor()
    }
    
    //random number generator
    private func chooseColor()
    {
        let randomInt = Int.random(in: 0..<100)
        switch randomInt
        {
        case 0..<40:
            self.color = "red"
            self.gameScore = 1
        case 40..<70:
            self.color = "pink"
            self.gameScore = 2
        case 70..<85:
            self.color = "green"
            self.gameScore = 5
        case 85..<95:
            self.color = "blue"
            self.gameScore = 8
        case 95..<100:
            self.color = "black"
            self.gameScore = 10
        default:
            self.color = "nil"
        }
    }
}


//var b = Balloon()
//print("color is: \(b.color) and gameScore is \(b.gameScore!)")

//if let a = optionalA, b = optionalB { ... }
//var b = Balloon()
//let
//if let b.color = optionalBcolor, b.gameScore = optionalBgs
//{
//    print("color is: \(b.color) and gameScore is \(b.gameScore!)")
//}

//let first = p.first ?? ""
//let last = p.last ?? ""
//let both = !first.isEmpty && !last.isEmpty
//let full = first + (both ? " " : "") + last
