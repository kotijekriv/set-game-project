//
//  SetGame.swift
//  Set
//
//  Created by Pero Radich on 27.07.2021..
//

import Foundation

struct SetGame {
    private(set) var deck: Array<Card>
    private(set) var cards: Array<Card>
    private(set) var cardsFaceUp: Array<Card>
    private(set) var score: Int
    private(set) var threeCardsUp: Bool
    private(set) var isSetFound: Bool
    
    mutating func choose(_ card: Card){
        
        if threeCardsUp && isSetFound {
            if !deck.isEmpty{
                var check = false
                
                for index in 0..<3 {
                    if let chosenIndex = cards.firstIndex(where: {$0.id == cardsFaceUp[index].id}){
                        cards[chosenIndex] = deck[index]
                    }
                    check = true
                }
                if check{
                    deck.removeSubrange(0..<3)
                }
            }else{
                for index in 0..<3 {
                    cards.removeAll(where: {$0.id == cardsFaceUp[index].id})
                }
            }
            
            cardsFaceUp.removeAll()
            
            //if cards are SET you get +3 points
            score+=3
            
            isSetFound = false
            threeCardsUp = false
            
        }else if threeCardsUp && !isSetFound{
            for i in 0..<3 {
                if let chosenIndex = cards.firstIndex(where: {$0.id == cardsFaceUp[i].id}){
                    cards[chosenIndex].isFaceUp = false
                }
            }
            cardsFaceUp.removeAll()
            
            //if cards are not SET you get -2 points
            score-=2
            
            threeCardsUp = false
        }
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            
            if !cards[chosenIndex].isFaceUp {
                //if the card is not face up turn it face up
                //and do something with it
                
                cardsFaceUp.append(cards[chosenIndex])
                
                if cardsFaceUp.count==3{
                    if isSet(cards: cardsFaceUp){
                      isSetFound = true
                    }
                    threeCardsUp = true
                }
                cards[chosenIndex].isFaceUp = true
            } else{
                //If face up card is selected, verify how many cards are there and
                //let the user to turn the card face down
                if !(cardsFaceUp.count==3) && !isSetFound{
                    cardsFaceUp.removeAll(where: {$0.id == cards[chosenIndex].id})
                    cards[chosenIndex].isFaceUp = false
                }
            }
        }
    }
    
    mutating func drawCards(){
        if !deck.isEmpty{
            for index in 0..<3{
                cards.append(deck[index])
            }
            deck.removeSubrange(0..<3)
        }
    }
    
    init() {
        deck = []
        cards = []
        cardsFaceUp = []
        score = 0
        
        deck.removeAll()
        cards.removeAll()
        cardsFaceUp.removeAll()
        
        threeCardsUp = false
        isSetFound = false
        
        createADeck()
        deck.shuffle()
        
        //TODO review
        for index in 0..<12 {
            cards.append(deck[index])
        }
        deck.removeSubrange(0..<12)
    }
    
    //MARK: -Creating a new deck
    
    mutating func createADeck(){
        deck.removeAll()
        var i: Int = 0
        for color in CardColor.allValues{
            for shading in CardShading.allValues{
                for symbol in CardSymbol.allValues{
                    for number in CardNumber.allValues{
                        deck.append(Card(shading: shading, color: color, symbol: symbol, number: number, id: i))
                        i+=1
                    }
                }
            }
        }
    }
    
    //MARK: -isSet function
    
    private func isSet(cards: Array<Card>) -> Bool{
        let firstCard = cards[0]
        let secondCard = cards[1]
        let thirdCard = cards[2]
        
        return noTwoOf(firstCard.shading, secondCard.shading, thirdCard.shading) &&
            noTwoOf(firstCard.color, secondCard.color, thirdCard.color) &&
            noTwoOf(firstCard.symbol, secondCard.symbol, thirdCard.symbol) &&
            noTwoOf(firstCard.number, secondCard.number, thirdCard.number)
    }

    private func noTwoOf<T: Comparable>(_ first: T, _ second: T, _ third: T) -> Bool {
        
        return !((first == second && first != third) ||
            (first == third && first != second) ||
            (second == third && first != second))
    }
}
