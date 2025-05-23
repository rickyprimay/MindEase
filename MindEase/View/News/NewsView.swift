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
        
        VStack {
            Text("Ini Halaman berita")
        }
        .onAppear {
            newsViewModel.getNews()
        }
        
    }
    
}
