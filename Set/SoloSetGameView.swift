//
//  SetGameView.swift
//  Set
//
//  Created by Pero Radich on 27.07.2021..
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SoloSetGame
    
    var body: some View {
        VStack{
            HStack{
                newGame
                Spacer()
                score
            }
            .padding()
            
            Spacer()
            gameBody
            Spacer()
            
            HStack{
                discardPileBody
                Spacer()
                deckBody
            }
            .padding()
        }
    }
    
    var score: some View{
        Text("SCORE: \(game.score)")
            .foregroundColor(.blue)
            .bold()
    }
    
    var gameBody: some View{
        AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
            CardView(card: card, isDealt: true, threeCardsUp: game.threeCardsUp, isSetFound: game.isSetFound)
                .onTapGesture {
                    game.choose(card)
                    
                }
        }
    }
    
    var newGame: some View{
        Button("NEW GAME"){
            game.newGame()
        }
    }
    
    //Edit this discardPileBody
    var discardPileBody: some View{
        ZStack{
            ForEach(game.discardPile){ card in
                CardView(card: card, isDealt: true, threeCardsUp: false, isSetFound: false)
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
    }
    
    //Edit this deckBody
    var deckBody: some View{
        ZStack{
            ForEach(game.deck){ card in
                CardView(card: card, isDealt: false, threeCardsUp: false, isSetFound: false)
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
    }
    
    private struct CardConstants{
        static let aspectRatio: CGFloat = 2/3
        static let undealHeight: CGFloat  = 90
        static let undealWidth = undealHeight * aspectRatio
    }
}

struct CardView: View{
    let card: Card
    let isDealt: Bool
    let threeCardsUp: Bool
    let isSetFound: Bool
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill()
                    .foregroundColor(cardColor(isFaceUp: card.isFaceUp))
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.orange)
                cardContent
                    .padding(DrawingConstants.contentViewPadding)
                    .opacity(isDealt ? 1 : 0)
            }
        }
        .padding(3)
    }
    
    var cardContent: some View {
        GeometryReader { geometry in
            VStack{
                switch card.number{
                case .one:
                    CardSymbolView(card: card)
                case .two:
                    CardSymbolView(card: card)
                    CardSymbolView(card: card)
                case .three:
                    CardSymbolView(card: card)
                    CardSymbolView(card: card)
                    CardSymbolView(card: card)
                }
            }
        }
    }
    
    private func cardColor(isFaceUp: Bool) ->Color{
        if isFaceUp && threeCardsUp && isSetFound {
            return .yellow
        }else if isFaceUp && threeCardsUp {
            return .gray
        }else if isFaceUp || !isDealt{
            return .orange
        }else{
            return .white
        }
    }
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1.5
        static let contentViewPadding: CGFloat = 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SetGameView(game: game)
    }
}
