//
//  HeartProgress.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct HeartProgress: View {
    var progress: CGFloat // 0.0 ... 1.0
    var parallaxOffset: CGFloat // untuk efek parallax
    var color: Color

    var body: some View {
        ZStack {
            // Heart shape outline
            HeartShape()
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                .frame(width: 140, height: 140)
            
            HeartShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.5)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 140, height: 140)
                .mask(
                    VStack {
                        Spacer(minLength: 0)
                        Rectangle()
                            .frame(height: 140 * progress + parallaxOffset)
                            .foregroundColor(.white)
                    }
                )
                .animation(.easeInOut, value: progress)
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .shadow(radius: 2)
        }
        .frame(width: 140, height: 140)
    }
}
