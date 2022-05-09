//
//  LeaderboardView.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//
import Foundation
import SwiftUI
//import Firebase

struct LeaderboardView: View {
    
    @ObservedObject var model = LeaderboardViewModel()
    
    @State var id = ""
    @State var username = ""
    @State var score = 0
    @State var time = 0
    
    var body: some View {
        NavigationView {
            List (model.list) { item in
                VStack(alignment: .leading) {
                    Text("User: \(item.username)")
                        .font(.title)
                    Spacer()
                    HStack(spacing: 1) {
                        Text("Score: \(String(item.score))")
                            .font(.subheadline)
                        Spacer()
                        Text("Time: \(String(item.time))")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Leaderboard")
        }
    }
    init() {
        model.getData()
    }
}

var leaderChild = UIHostingController(rootView: LeaderboardView())

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View{
        LeaderboardView()
    }
}
