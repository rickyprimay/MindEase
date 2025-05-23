//
//  SuggestionCard.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

struct SuggestionCard: View {
    let icon: String
    let color: Color
    let title: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(AppFont.Poppins.bold(32))
                    .foregroundColor(color)
                Text(title)
                    .font(AppFont.Poppins.regular(14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 150, height: 80)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
        }
    }
}
