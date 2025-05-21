//
//  MoodJourneyCard.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct MoodJourneyCard: View {
    var progress: CGFloat
    var parallaxOffset: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mood journey this week")
                .font(AppFont.Poppins.bold(16))
            Text("Discover how your emotions evolved over the last 7 days.")
                .font(AppFont.Poppins.regular(13))
                .foregroundColor(.gray)
            Spacer()
            HStack {
                Spacer()
                HeartProgress(
                    progress: progress,
                    parallaxOffset: parallaxOffset,
                    color: Color("PastelBlue")
                )
                Spacer()
            }
            Spacer()
            Text("You're feeling good this week")
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
