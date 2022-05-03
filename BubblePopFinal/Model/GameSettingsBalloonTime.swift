//
//  GameSettings.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
//
//create observable class
import Foundation
import SwiftUI

class GameSettingsBalloonTime: ObservableObject {
    @Published(key: "balloonSeconds") var gameTime = 60.0
}
