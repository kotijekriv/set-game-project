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
            VStack{
                Text("SET")
                    .foregroundColor(.blue)
                    .bold()
                    .font(.largeTitle)
                    .padding(.bottom)
            }
            Spacer()
            AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
                CardView(card: card)
                    .padding(3)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            Spacer()
            HStack{
                Button("DRAW CARDS"){
                    //TODO SOME ACTION
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding()
            
        }
        
    }
}

struct CardView: View {
    let card: Card
    
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
        if isFaceUp {
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
