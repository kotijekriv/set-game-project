//
//  SoloSetGame.swift
//  Set
//
//  Created by Pero Radich on 27.07.2021..
//

import SwiftUI

class SoloSetGame: ObservableObject {
    
    private static func createSetGame() -> SetGame{
        SetGame()
    }
    
    @Published private var model = createSetGame()
    
    var deck: Array<Card>{
        return model.deck
    }
    
    var discardPile: Array<Card>{
        return model.discardPile
    }
    
    var cards: Array<Card>{
        return model.cards
    }
    
    var score: Int{
        return model.score
    }
    
    var threeCardsUp: Bool{
        return model.threeCardsUp
    }
    
    var isSetFound: Bool{
        return model.isSetFound
    }
    
    //MARK: - Intent(s)
    
    func newGame() {
        model = SoloSetGame.createSetGame()
    }
    
    func drawCards() {
        model.drawCards()
    }
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
