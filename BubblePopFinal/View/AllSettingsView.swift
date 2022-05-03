//
//  AllSettingsView.swift
//  BubblePop
//
//  Created by Samuel Polgar on 29/4/2022.
//
import Foundation
import SwiftUI

struct AllSettingsView: View {
    @StateObject var gameSettingsBalloonNo = GameSettingsBalloonNo()
    @StateObject var gameSettingsBalloonTime = GameSettingsBalloonTime()
    
    var body: some View {
        NavigationView {
            List{
                BalloonSettingsView()
                    .padding()
                    .clipped()
                    .listRowInsets(EdgeInsets())
                CountdownTimerSettingsView()
                    .padding()
                    .clipped()
                    .listRowInsets(EdgeInsets())
                    .navigationTitle("Settings")
                    .padding()
            }
        }
    }
}

struct BalloonSettingsView: View {
    @StateObject var gameSettingsBalloonNo = GameSettingsBalloonNo()
    @State private var hasChangedBalloon: Bool = false;
    private let balloonRange: ClosedRange<Double> = 1...15
    private let balloonStep: Double = 1.0
    
    var body: some View {
        VStack {
            if gameSettingsBalloonNo.balloonNo == 1.0 {
                Text("Minimum balloon count is 1!")
            } else {
                Text("Balloons on screen \(Int(gameSettingsBalloonNo.balloonNo))")
            }
            HStack {
                Slider(value: $gameSettingsBalloonNo.balloonNo, in: balloonRange, step: balloonStep) {
                }
            }
        }
        .padding()
        .environmentObject(gameSettingsBalloonNo)
    }
}


struct CountdownTimerSettingsView: View {
    @StateObject var gameSettingsBalloonTime = GameSettingsBalloonTime()
    @State private var hasChanged: Bool = false;
    private let timeRange: ClosedRange<Double> = 1...60
    private let timeStep: Double = 1.0
    
    var body: some View {
        VStack {
            if gameSettingsBalloonTime.gameTime == 1.0 {
                Text("Minimum 1 second game!")
            } else {
                Text("\(Int(gameSettingsBalloonTime.gameTime)) seconds game")
            }
            HStack {
                Slider(value: $gameSettingsBalloonTime.gameTime, in: timeRange, step: timeStep) {
                }
            }
        }
        .padding()
        .environmentObject(gameSettingsBalloonTime)
    }
}

//var child = UIHostingController(rootView: AllSettingsView())

struct AllSettingsView_Previews: PreviewProvider {
    static var previews: some View{
        AllSettingsView()
    }
}
