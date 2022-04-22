//
//  CountDownClock.swift
//  BubblePop
//
//  Created by Samuel Polgar on 19/4/2022.
//credit to https://tutorials.tinyappco.com/SwiftGames/Timer
import SpriteKit
class Timer: SKLabelNode {
//    var countdownDuration: Int
    var endTime:Date!
    
    override init () {
        super.init()
        setup()
    }
    
    func setup(){
//        self.verticalAlignmentMode = .center
//        self.fontSize = 65
//        self.fontColor = UIColor.white
    }
 
    func update(){
        let timeLeftInteger = Int(timeLeft())
        self.text = String(timeLeftInteger)
    }
    
    func startWithDuration(durationInSeconds: TimeInterval){
        let timeNow = Date()
        endTime = timeNow.addingTimeInterval(durationInSeconds)
    }
    
    private func timeLeft() -> TimeInterval {
        let now = Date()
        let remainingSeconds = endTime.timeIntervalSince(now)
        return max(remainingSeconds, 0)
    }
    
    func hasFinished() -> Bool {
        return timeLeft() == 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      }

}
