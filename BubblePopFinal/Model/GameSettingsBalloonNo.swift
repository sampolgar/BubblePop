//
//  GameSettings.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//
//create observable class
import Foundation
import SwiftUI

class GameSettingsBalloonNo: ObservableObject {
    @Published(key: "balloonNo") var balloonNo = 15.0
}
