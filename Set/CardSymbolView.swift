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
                    StripView(shape: Triangle(),color: cardColor(card))
                        .foregroundColor(cardColor(card))
                }else{
                    Triangle().fill(Color.white)
                    Triangle().fill(cardColor(card)).opacity(cardShading(card))
                    Triangle()
                        .stroke(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(cardColor(card))
                }
            case .squiggle:
                if card.shading == .stripe {
                    StripView(shape: Rectangle(),color: cardColor(card))
                        .foregroundColor(cardColor(card))
                }else{
                    Rectangle().fill(Color.white)
                    Rectangle().fill(cardColor(card)).opacity(cardShading(card))
                    Rectangle()
                        .inset(by: DrawingConstants.inset)
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
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
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



struct CardSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card.init(shading: .stripe, color: .purple, symbol: .diamond, number: .three, id: 69)
        
        CardSymbolView(card: card)
    }
}
