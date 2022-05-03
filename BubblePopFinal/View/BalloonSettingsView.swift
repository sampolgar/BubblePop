//
//  BalloonSettingsView.swift
//  BubblePop
//
//  Created by Samuel Polgar on 29/4/2022.
//
//import Foundation
//import SwiftUI
//
//struct BalloonSettingsView: View {
//
//    @StateObject var gameSettings = GameSettings()
//    
////    @State private var balloonNo: Double = 15
//    @State private var hasChanged: Bool = false;
//    
//    private let range: ClosedRange<Double> = 1...15
//    private let step: Double = 1.0
//    
//    var body: some View {
//        VStack {
//            if gameSettings.balloonNo == 1.0 {
//                Text("Minimum balloon count is 1!")
//            } else {
//                Text("Balloons on screen \(Int(gameSettings.balloonNo))")
//            }
//            HStack {
//                Slider(value: $gameSettings.balloonNo, in: range, step: step) {
//                }
//            }
//        }
//        .padding()
//    }
//}
////
//struct BalloonSettingsView_Previews: PreviewProvider {
//    static var previews: some View{
//        BalloonSettingsView()
//    }
//}
