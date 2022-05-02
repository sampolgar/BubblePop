//
//  AllSettingsView.swift
//  BubblePop
//
//  Created by Samuel Polgar on 29/4/2022.
//
import Foundation
import SwiftUI

struct AllSettingsView: View {
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

var child = UIHostingController(rootView: AllSettingsView())

//struct AllSettingsView_Previews: PreviewProvider {
//    static var previews: some View{
//        AllSettingsView()
//    }
//}
