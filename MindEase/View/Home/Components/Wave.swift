//
//  Wave.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

struct Wave: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    var phase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height            
        let baseHeight = (1.0 - progress) * height
        
        path.move(to: CGPoint(x: 0, y: baseHeight))
        
        for x in stride(from: 0, to: width + 1, by: 1) {
            let relativeX = x / width
            let sine = sin(relativeX * .pi * 2 + phase)
            let y = baseHeight + sine * waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
}
