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
                    .font(AppFont.Poppins.regular(24))
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
                                NewsCard(news: article)
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
