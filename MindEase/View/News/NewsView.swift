//
//  NewsView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 23/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsView: View {
    
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Berita Kesehatan Mental")
                    .font(AppFont.Poppins.bold(24))
                    .padding(.horizontal)
                
                if newsViewModel.isLoading {
                    ProgressView("Memuat berita...")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(newsViewModel.news.indices, id: \.self) { index in
                                let article = newsViewModel.news[index]
                                NewsCardView(news: article)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            newsViewModel.getNews()
        }
    }
}

struct NewsCardView: View {
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
