//
//  HeartProgress.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct HeartProgress: View {
    var progress: CGFloat
    var color: Color
    @State private var phase1: CGFloat = 0
    @State private var phase2: CGFloat = 0
    @State private var phase3: CGFloat = 0

    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            HeartShape()
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                .frame(width: 160, height: 160)

            ZStack {
                Wave(progress: progress, waveHeight: 10, phase: phase1)
                    .fill(color.opacity(0.4))
                Wave(progress: progress, waveHeight: 8, phase: phase2)
                    .fill(color.opacity(0.6))
                Wave(progress: progress, waveHeight: 6, phase: phase3)
                    .fill(color.opacity(0.8))
            }
            .frame(width: 160, height: 160)
            .mask(HeartShape().frame(width: 160, height: 160))

            Text("\(Int(progress * 100))%")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .shadow(radius: 2)
        }
        .frame(width: 140, height: 140)
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: 0.02)) {
                phase1 += 0.06
                phase2 += 0.04
                phase3 += 0.02
            }
        }
    }
}
