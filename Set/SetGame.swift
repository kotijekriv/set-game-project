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
    private var threeCardsUp: Bool
    private var isSetFound: Bool
    
    mutating func choose(_ card: Card){
        
        //TODO ADD situation when three cards are set and when they are not
        if threeCardsUp && isSetFound {
            for i in 0..<3 {
                cards.removeAll(where: {$0.id == cardsFaceUp[i].id})
            }
            cardsFaceUp.removeAll()
            isSetFound = false
            threeCardsUp = false
        }else if threeCardsUp && !isSetFound{
            for i in 0..<3 {
                if let chosenIndex = cards.firstIndex(where: {$0.id == cardsFaceUp[i].id}){
                    cards[chosenIndex].isFaceUp = false
                }
            }
            cardsFaceUp.removeAll()
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
                    
                } else{
                    
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
    
    init() {
        deck = []
        cards = []
        cardsFaceUp = []
        
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
}
