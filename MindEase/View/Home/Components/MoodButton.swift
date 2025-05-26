//
//  MoodButton.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct MoodButton: View {
    let image: String
    let label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                Text(label)
                    .font(AppFont.Poppins.regular(11))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
