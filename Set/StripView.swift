//
//  StripView.swift
//  Set
//
//  Created by Pero Radich on 28.07.2021..
//

import SwiftUI

struct StripView<T>: View where T: Shape {
    let numberOfStrips: Int = 5
    let lineWidth: CGFloat = 2
    let borderLineWidth: CGFloat = 1
    let shape: T
    let color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numberOfStrips) { number in
                Color.white
                color.frame(width: lineWidth)
                if number == numberOfStrips - 1 {
                    Color.white
                }
            }
            
        }
        .mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
    }
}


struct StripView_Previews: PreviewProvider {
    static var previews: some View {
        
        StripView(shape: CardSymbolView.Diamond(),color: .red)
    }
}
