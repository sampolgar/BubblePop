//
//  CountdownTimerSettingsView.swift
//  BubblePop
//
//  Created by Samuel Polgar on 29/4/2022.
//
//
//  BalloonSettingsView.swift
//  BubblePop
//
//  Created by Samuel Polgar on 29/4/2022.
//
import Foundation
import SwiftUI

struct CountdownTimerSettingsView: View {
    @State private var secondsNo: Double = 60
    @State private var hasChanged: Bool = false;
    
    private let range: ClosedRange<Double> = 1...60
    private let step: Double = 1.0
    
    var body: some View {
        VStack {
            if secondsNo == 1.0 {
                Text("Minimum 1 second game!")
            } else {
                Text("\(Int(secondsNo)) seconds game")
            }
            HStack {
                Slider(value: $secondsNo, in: range, step: step) {
                }
            }
        }
        .padding()
    }
}
//
//struct CountdownTimerSettingsView_Previews: PreviewProvider {
//    static var previews: some View{
//        CountdownTimerSettingsView()
//    }
//}
