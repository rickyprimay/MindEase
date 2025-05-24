//
//  NewsCardView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 24/05/25.
//

import SwiftUI

struct NewsCard: View {
    let news: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
                WebImage(url: url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                    .clipped()
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        Text("Tidak ada gambar")
                            .font(AppFont.Poppins.regular(16))
                            .foregroundColor(.gray)
                    )
                    .cornerRadius(10)
            }
            
            Text(news.title)
                .font(AppFont.Poppins.bold(16))
                .foregroundColor(.primary)
            
            if let desc = news.description {
                Text(desc)
                    .font(AppFont.Poppins.regular(14))
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            Text("Sumber: \(news.source.name)")
                .font(AppFont.Poppins.regular(12))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.4))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .frame(width: UIScreen.main.bounds.width - 32, height: 350)
    }
}
