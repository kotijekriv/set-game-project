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
            Spacer()
            AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
                CardView(card: card, threeCardsUp: game.threeCardsUp, isSetFound: game.isSetFound)
                    .padding(3)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            Spacer()
            HStack{
                Button("NEW GAME"){
                    game.newGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
                Spacer()
                
                Button("DRAW CARDS"){
                    game.drawCards()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding()
            
        }
        
    }
}

struct CardView: View {
    let card: Card
    let threeCardsUp: Bool
    let isSetFound: Bool
    
    var body: some View {
        
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
        
    }
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1.5
        static let contentViewPadding: CGFloat = 5
    }
    
    private func cardColor(isFaceUp: Bool) ->Color{
        if isFaceUp && threeCardsUp && isSetFound {
            return .yellow
        }else if isFaceUp && threeCardsUp {
            return .gray
        }else if isFaceUp{
            return .orange
        }else{
            return .white
        }
    }
}


struct CardContentView: View {
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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SetGameView(game: game)
    }
}
