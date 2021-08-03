//
//  SoloSetGame.swift
//  Set
//
//  Created by Pero Radich on 27.07.2021..
//

import SwiftUI

class SoloSetGame: ObservableObject {
    
    //typealias Card = SetGame.Card
    
    
    private static func createSetGame() -> SetGame{
        SetGame()
    }
    
    @Published private var model = createSetGame()
    
    var cards: Array<Card>{
        return model.cards
    }
    
    //MARK: - Intent(s)
    
    func newGame() {
        model = SoloSetGame.createSetGame()
    }
    
    func drawCards() {
        //model.drawCards
    }
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
