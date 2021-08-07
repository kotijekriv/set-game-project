//
//  CardSymbolView.swift
//  Set
//
//  Created by Pero Radich on 28.07.2021..
//

import SwiftUI

//Drawing each card symbol
struct CardSymbolView: View {
    let card: Card
    
    var body: some View {
        
        ZStack{
            switch card.symbol {
            case .diamond:
                if card.shading == .stripe {
                    StripView(shape: Diamond(),color: cardColor(card))
                        .foregroundColor(cardColor(card))
                }else{
                    Diamond().fill(Color.white)
                    Diamond().fill(cardColor(card)).opacity(cardShading(card))
                    Diamond()
                        .stroke(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(cardColor(card))
                }
            case .squiggle:
                if card.shading == .stripe {
                    StripView(shape: Squiggle(),color: cardColor(card))
                        .foregroundColor(cardColor(card))
                }else{
                    Squiggle().fill(Color.white)
                    Squiggle().fill(cardColor(card)).opacity(cardShading(card))
                    Squiggle()
                        .stroke(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(cardColor(card))
                }
            case .oval:
                if card.shading == .stripe {
                    StripView(shape: Ellipse(),color: cardColor(card))
                        .foregroundColor(cardColor(card))
                }else{
                    Ellipse().fill(Color.white)
                    Ellipse().fill(cardColor(card)).opacity(cardShading(card))
                    Ellipse()
                        .inset(by: DrawingConstants.inset)
                        .stroke(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(cardColor(card))
                }
            }
        }
    }
    
    private func cardColor(_ card: Card) -> Color{
        switch card.color {
        case .green:
            return .green
        case .purple:
            return .purple
        case .red:
            return .red
        }
    }
    
    private func cardShading(_ card: Card) -> Double{
        switch card.shading {
        case .open:
            return 0
        case .stripe:
            return 0.5
        case .solid:
            return 1
        }
    }
    
    private struct DrawingConstants{
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 1
    }
    
}

struct CardSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card.init(shading: .stripe, color: .purple, symbol: .squiggle, number: .three, id: 69)
        
        CardSymbolView(card: card)
    }
}
