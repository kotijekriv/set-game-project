//
//  isSet.swift
//  Set
//
//  Created by Pero Radich on 31.07.2021..
//

import Foundation

func isSet(cards: Array<Card>) -> Bool{
    let firstCard = cards[0]
    let secondCard = cards[1]
    let thirdCard = cards[2]
    
    return noTwoOf(firstCard.shading, secondCard.shading, thirdCard.shading) &&
        noTwoOf(firstCard.color, firstCard.color, firstCard.color) &&
        noTwoOf(firstCard.symbol, secondCard.symbol, thirdCard.symbol) &&
        noTwoOf(firstCard.number, secondCard.number, thirdCard.number)
}

func noTwoOf<T: Comparable>(_ first: T, _ second: T, _ third: T) -> Bool {
    
    return !((first == second && first != third) ||
        (first == third && first != second) ||
        (second == third && first != second))
}
