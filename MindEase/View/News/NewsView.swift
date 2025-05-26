//
//  NewsView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 23/05/25.
//

import SwiftUI

struct NewsView: View {
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelBlue").opacity(0.2)
                    .ignoresSafeArea()
                
                if newsViewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView("Memuat berita...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .font(.headline)
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(newsViewModel.news.indices, id: \.self) { index in
                                let article = newsViewModel.news[index]
                                NewsCard(news: article)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Berita")
            .onAppear {
                if newsViewModel.news.isEmpty {
                    newsViewModel.getNews()
                }
            }
        }
    }
}
