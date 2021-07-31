//
//  Card.swift
//  Set
//
//  Created by Pero Radich on 29.07.2021..
//

import Foundation


struct Card: Identifiable{
    
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//            return lhs.cardColor == rhs.cardColor &&
//                lhs.cardNumber == rhs.cardNumber &&
//                lhs.cardShading == rhs.cardShading &&
//                lhs.cardSymbol == rhs.cardSymbol
//        }
    
    var shading: CardShading
    var color: CardColor
    var symbol: CardSymbol
    var number: CardNumber
    var isFaceUp = false
    var id: Int
}

enum CardShading {
    case open
    case stripe
    case solid
    
    static let allValues = [open, stripe, solid]
}

enum CardColor {
    case green
    case red
    case purple
    
    static let allValues = [green, red, purple]
}

enum CardSymbol {
    case diamond
    case squiggle
    case oval
    
    static let allValues = [diamond, squiggle, oval]
}

enum CardNumber {
    case one
    case two
    case three
    
    static let allValues = [one, two, three]
}

