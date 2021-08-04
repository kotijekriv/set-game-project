//
//  CardSymbolView.swift
//  Set
//
//  Created by Pero Radich on 28.07.2021..
//

import SwiftUI

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
    
    private struct DrawingConstants{
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 1
    }
    
    
    
    struct Diamond: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.midX, y:rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            
            return path
        }
    }
    
    struct Squiggle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y:rect.midY/2))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY-rect.midY*(3/4)))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY-rect.midY/2),
                              control: CGPoint(x: rect.maxX-rect.midX/2, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY*(3/4)))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY/2),
                               control: CGPoint(x: rect.midX/2, y: rect.minY))
            
            
            return path
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
    
}

struct CardSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card.init(shading: .stripe, color: .purple, symbol: .squiggle, number: .three, id: 69)
        
        CardSymbolView(card: card)
    }
}
