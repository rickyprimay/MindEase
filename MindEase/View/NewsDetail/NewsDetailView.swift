//
//  NewsDetailView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 25/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsDetailView: View {
    let news: News
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
                        WebImage(url: url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 32, height: 300)
                            .cornerRadius(16)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 250)
                            .overlay(
                                Text("Tidak ada gambar")
                                    .font(AppFont.Poppins.regular(16))
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    Text(news.title)
                        .font(AppFont.Poppins.bold(20))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    if let content = news.content {
                        Text(content)
                            .font(AppFont.Poppins.regular(16))
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                    } else if let description = news.description {
                        Text(description)
                            .font(AppFont.Poppins.regular(16))
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                    } else {
                        Text("Konten tidak tersedia.")
                            .font(AppFont.Poppins.regular(16))
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    
                    Text("Sumber: \(news.source.name)")
                        .font(AppFont.Poppins.regular(12))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    if let url = URL(string: news.url) {
                        Link("Baca Selengkapnya", destination: url)
                            .font(AppFont.Poppins.bold(14))
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
            .frame(width: UIScreen.main.bounds.width - 32)
        }
        .navigationTitle("Detail Berita")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
