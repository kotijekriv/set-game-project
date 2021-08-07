//
//  Squiggle.swift
//  Set
//
//  Created by Pero Radich on 07.08.2021..
//

import SwiftUI

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
