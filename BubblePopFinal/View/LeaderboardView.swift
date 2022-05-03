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
    
//    @ObservedObject var model = LeaderboardViewModel()
    
    @State var id = ""
    @State var score = 0
    @State var time = 0
    @State var userid = ""
    
//    var body: some View {
//        NavigationView {
//            List (model.list) { item in
//                VStack(alignment: .leading) {
//                    Text("User: \(item.userid)")
//                        .font(.title)
//                    Spacer()
//                    HStack(spacing: 1) {
//                        Text("Score: \(String(item.score))")
//                            .font(.subheadline)
//                        Spacer()
//                        Text("Time: \(String(item.time))")
//                            .font(.subheadline)
//                    }
//                }
//            }
//            .navigationTitle("Leaderboard")
//        }
//    }
    
    var body: some View {
        NavigationView {
            
        }.navigationTitle("Leaderboard")
    }
    //        NavigationView {
    //            List (model.list) { item in
    //                VStack(alignment: .leading) {
    //                    Text("User: \(item.userid)")
    //                        .font(.title)
    //                    Spacer()
    //                    HStack(spacing: 1) {
    //                        Text("Score: \(String(item.score))")
    //                            .font(.subheadline)
    //                        Spacer()
    //                        Text("Time: \(String(item.time))")
    //                            .font(.subheadline)
    //                    }
    //                }
    //            }
    //
    //        }
    //    }
    
//    init() {
//        model.getData()
//    }
}

//var leaderChild = UIHostingController(rootView: LeaderboardView())

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View{
        LeaderboardView()
    }
}


//
////
////  LeaderboardView.swift
////  BubblePop
////
////  Created by Samuel Polgar on 29/4/2022.
//import Foundation
//import SwiftUI
//import Firebase
//
//struct LeaderboardView: View {
//    
//    @ObservedObject var model = LeaderboardViewModel()
//    
//    @State var id = ""
//    @State var score = 0
//    @State var time = 0
//    @State var userid = ""
//    
//    var body: some View {
//        NavigationView {
//            List (model.list) { item in
//                VStack(alignment: .leading) {
//                    Text("User: \(item.userid)")
//                        .font(.title)
//                    Spacer()
//                    HStack(spacing: 1) {
//                        Text("Score: \(String(item.score))")
//                            .font(.subheadline)
//                        Spacer()
//                        Text("Time: \(String(item.time))")
//                            .font(.subheadline)
//                    }
//                }
//            }
//            .navigationTitle("Leaderboard")
//        }
//    }
//    
//    init() {
//        model.getData()
//    }
//}
//
//var leaderChild = UIHostingController(rootView: LeaderboardView())
//
////
////struct LeaderboardView_Previews: PreviewProvider {
////    static var previews: some View{
////        LeaderboardView()
////    }
////}
//
