//
//  NewsViewModel.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 23/05/25.
//

import Foundation
import Alamofire

class NewsViewModel: ObservableObject {
    
    let apiKey = "00d4a2d95c264cd6a334c50b813bd2fc"
    
    var baseUrl: String {
        return "https://newsapi.org/v2/everything?q=mental%20health&language=en&sortBy=publishedAt&apiKey=\(apiKey)"
    }
    
    @Published var news: [News] = []
    @Published var isLoading: Bool = false
    
    func getNews() {
        self.isLoading = true
        AF.request(baseUrl).responseDecodable(of: NewsResponse.self) { response in
            self.isLoading = false
            switch response.result {
            case .success(let data):
                print("✅ Decoded response:")
                print(data.articles)
                DispatchQueue.main.async {
                    self.news = data.articles
                }
            case .failure(let error):
                print("❌ Error decoding:")
                print("Error fetching news: \(error.localizedDescription)")
            }
        }
    }
}
