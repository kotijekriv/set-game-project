//
//  Card.swift
//  Set
//
//  Created by Pero Radich on 29.07.2021..
//

import Foundation


struct Card: Identifiable{
    var shading: CardShading
    var color: CardColor
    var symbol: CardSymbol
    var number: CardNumber
    var isFaceUp = false
    var id: Int
}

enum CardShading: Comparable {
    case open
    case stripe
    case solid
    
    static let allValues = [open, stripe, solid]
}

enum CardColor: Comparable{
    case green
    case red
    case purple
    
    static let allValues = [green, red, purple]
}

enum CardSymbol: Comparable {
    case diamond
    case squiggle
    case oval
    
    static let allValues = [diamond, squiggle, oval]
}

enum CardNumber: Comparable{
    case one
    case two
    case three
    
    static let allValues = [one, two, three]
}

