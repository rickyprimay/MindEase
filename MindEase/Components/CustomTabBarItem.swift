//
//  CustomTabBarItem.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

struct CustomTabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let isCenter: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                if isCenter {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("PastelBlue"), Color.purple.opacity(0.6)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 64, height: 64)
                            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                        Image(systemName: icon)
                            .font(AppFont.Poppins.bold(24))
                            .foregroundColor(.white)
                    }
                    .offset(y: -24)
                } else {
                    Image(systemName: icon)
                        .font(AppFont.Poppins.regular(24))
                        .foregroundColor(isSelected ? .black : .gray)
                    Text(title)
                        .font(isSelected ? AppFont.Poppins.bold(12) : AppFont.Poppins.regular(12))
                        .foregroundColor(isSelected ? .black : .gray)
                }
            }
        }
    }
}
