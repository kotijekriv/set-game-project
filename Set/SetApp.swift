//
//  SetApp.swift
//  Set
//
//  Created by Pero Radich on 27.07.2021..
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SoloSetGame()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
