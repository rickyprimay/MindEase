//
//  ChatViewModel.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import Foundation
import GoogleGenerativeAI
import Alamofire
import AVFoundation

class ChatViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var animatedText = ""
    @Published var content: String? = nil
    @Published var isAnimatingText = false
    
    let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyCMZoLNkDoL6Gc-1Ae1gt8sIeBoqYkZBqM")
    
    func sendPromptToGemini(prompt: String) {
        Task {
            do {
                let systemMessage = """
                Kamu adalah AI terapis  di aplikasi MindEase, yang dirancang untuk membantu pengguna menjaga kesehatan mental mereka. Jawaban kamu harus bersifat empatik, suportif, dan relevan dengan topik seperti stres, kecemasan, mindfulness, perasaan, dan self-care.

                Jangan memberikan saran medis, diagnosis penyakit, atau jawaban di luar konteks kesehatan mental. Jika pertanyaan tidak relevan, dengan sopan arahkan pengguna kembali ke topik kesehatan mental atau sarankan untuk menghubungi profesional.

                Jawablah dalam Bahasa Indonesia yang santai, nyaman, dan mudah dipahami.
                """

                let response = try await model.generateContent(systemMessage + prompt)
                if let text = response.text {
                    await self.startTextAnimation(textUsing: text)
                }
            } catch {
                print("Error sending prompt to Gemini: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func startTextAnimation(textUsing: String) async {
        guard !isAnimatingText else { return }
        animatedText = ""
        isAnimatingText = true
        
        let characters = Array(textUsing)
        for char in characters {
            animatedText.append(char)
            try? await Task.sleep(nanoseconds: 30_000_000)
        }
        isAnimatingText = false
    }
    
}
