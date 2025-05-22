//
//  MoodJourneyCard.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct MoodJourneyCard: View {
    var progress: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Perjalanan suasana hati minggu ini")
                .font(AppFont.Poppins.bold(16))
            Text("Temukan bagaimana emosi Anda berkembang selama 7 hari terakhir.")
                .font(AppFont.Poppins.regular(13))
                .foregroundColor(.gray)
                .lineLimit(2)
            Spacer()
            HStack {
                Spacer()
                HeartProgress(
                    progress: progress,
                    color: Color("PastelBlue")
                )
                Spacer()
            }
            Spacer()
            Text("Anda merasa baik minggu ini")
                .font(AppFont.Poppins.regular(13))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(
            Color.white
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.07), radius: 8, x: 4, y: 4)
        )
    }
}
