//
//  SetGameView.swift
//  Set
//
//  Created by Pero Radich on 27.07.2021..
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SoloSetGame
    
    @Namespace private var dealingNameSpace
    
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
            CardView(card: card, isDealt: true, isMatched: game.cardsFaceUp.contains(where: { $0.id == card.id}), threeCardsUp: game.threeCardsUp, isSetFound: game.isSetFound)
                .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                .transition(AnyTransition.asymmetric(insertion: .slide, removal: .slide))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation{
                        game.choose(card)
                    }
                }
        }
    }
    
    var newGame: some View{
        Button("NEW GAME"){
            withAnimation{
                game.newGame()
            }
        }
    }
    
    //Edit this discardPileBody
    var discardPileBody: some View{
        ZStack{
            ForEach(game.discardPile){ card in
                withAnimation(dealAnimation(for: card)){
                    CardView(card: card, isDealt: true, isMatched: false, threeCardsUp: false, isSetFound: false)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .transition(AnyTransition.asymmetric(insertion: .slide, removal: .slide))
                        .zIndex(zIndex(of: card))
                }
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
    }
    
    //Edit this deckBody
    var deckBody: some View{
        ZStack{
            ForEach(game.deck){ card in
                CardView(card: card, isDealt: false, isMatched: false, threeCardsUp: false, isSetFound: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
        .onTapGesture {
            withAnimation{
                game.drawCards()
            }
        }
    }
    
    private func zIndex(of card: Card) -> Double{
        if let index = game.deck.firstIndex(where: { $0.id == card.id }){
            return -Double(index)
        } else if let index = game.cards.firstIndex(where: { $0.id == card.id }){
            return -Double(index)
        } else if let index = game.discardPile.firstIndex(where: { $0.id == card.id }){
            return -Double(index)
        }
        return 0
    }
    
    private func dealAnimation(for card: Card) -> Animation{
        var delay = 0.0
        
        if let index = game.deck.firstIndex(where: { $0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.deck.count))
        } else if let index = game.cards.firstIndex(where: { $0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        } else if let index = game.discardPile.firstIndex(where: { $0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.discardPile.count))
        }
        
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private struct CardConstants{
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let aspectRatio: CGFloat = 2/3
        static let undealHeight: CGFloat  = 90
        static let undealWidth = undealHeight * aspectRatio
    }
}

struct CardView: View{
    let card: Card
    let isDealt: Bool
    let isMatched: Bool
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
                Text("M")
                    .font(.title)
                    .opacity(isMatched && isSetFound && threeCardsUp ? 1 : 0)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
//                    .rotationEffect(Angle.degrees(isMatched && isSetFound && threeCardsUp ? 360 : 0))
//                    .animation(Animation.linear(duration: 1))
                Text("F")
                    .font(.title)
                    .opacity((isMatched && threeCardsUp && !isSetFound) ? 1 : 0)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
                    .rotationEffect(Angle.degrees(isMatched && threeCardsUp && !isSetFound ? 360 : 0))
                    .animation(Animation.linear(duration: 1))
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
