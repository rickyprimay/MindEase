//
//  MoodButton.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct MoodButton: View {
    let emoji: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(emoji)
                .font(.system(size: 32))
                .frame(width: 48, height: 48)
                .background(Color(.systemGray6))
                .clipShape(Circle())
            Text(label)
                .font(AppFont.Poppins.regular(12))
                .foregroundColor(.primary)
        }
    }
}
