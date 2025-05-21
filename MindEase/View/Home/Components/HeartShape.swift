//
//  HeartShape.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: height * 0.9))
        path.addCurve(
            to: CGPoint(x: 0, y: height * 0.35),
            control1: CGPoint(x: width * 0.2, y: height * 0.9),
            control2: CGPoint(x: 0, y: height * 0.6)
        )
        path.addArc(
            center: CGPoint(x: width * 0.25, y: height * 0.25),
            radius: width * 0.25,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false
        )
        path.addArc(
            center: CGPoint(x: width * 0.75, y: height * 0.25),
            radius: width * 0.25,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false
        )
        path.addCurve(
            to: CGPoint(x: width / 2, y: height * 0.9),
            control1: CGPoint(x: width, y: height * 0.6),
            control2: CGPoint(x: width * 0.8, y: height * 0.9)
        )
        return path
    }
}
