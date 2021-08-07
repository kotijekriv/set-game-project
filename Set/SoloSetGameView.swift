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
            gameHeadline
            Spacer()
            gameBody
            Spacer()
            HStack{
                newGame
                Spacer()
                drawCards
            }
            .padding()
        }
    }
    
    var gameHeadline: some View{
        HStack{
            Text("SET GAME")
                .foregroundColor(.blue)
                .bold()
                .font(.largeTitle)
            Spacer()
            Text("SCORE: \(game.score)")
                .foregroundColor(.blue)
                .bold()
                .font(.subheadline)
        }
        .padding()
    }
    
    var gameBody: some View{
        AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
            GeometryReader { geometry in
                ZStack{
                    let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    shape.fill()
                        .foregroundColor(cardColor(isFaceUp: card.isFaceUp))
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.orange)
                    CardContentView(card: card)
                        .padding(DrawingConstants.contentViewPadding)
                }
            }
            .padding(3)
            .onTapGesture {
                game.choose(card)
                
            }
        }
    }
    
    var newGame:some View{
        Button("NEW GAME"){
            game.newGame()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
    
    var drawCards: some View{
        Button("DRAW CARDS"){
            game.drawCards()
        }
        .padding()
        .background(Color.orange)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
    
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1.5
        static let contentViewPadding: CGFloat = 5
    }
    
    private func cardColor(isFaceUp: Bool) ->Color{
        if isFaceUp && game.threeCardsUp && game.isSetFound {
            return .yellow
        }else if isFaceUp && game.threeCardsUp {
            return .gray
        }else if isFaceUp{
            return .orange
        }else{
            return .white
        }
    }
    
    private struct CardContentView: View {
        let card: Card
        
        var body: some View{
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
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SetGameView(game: game)
    }
}
