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
    private let synthesizer = AVSpeechSynthesizer()
    
    let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyCMZoLNkDoL6Gc-1Ae1gt8sIeBoqYkZBqM")
    
    func sendPromptToGemini(prompt: String, usingTTS: Bool, completion: @escaping () -> Void) {
        Task {
            do {
                let systemMessage = """
                Kamu adalah AI terapis di aplikasi MindEase. Peranmu adalah menjadi teman ngobrol yang suportif dan penuh empati untuk pengguna yang sedang mengalami stres, kecemasan, kesepian, atau perasaan sulit lainnya.
                
                Gunakan gaya bahasa santai, ramah, dan terasa seperti teman yang mengerti, bukan seperti layanan darurat atau robot resmi. Hindari jawaban terlalu formal atau seperti template layanan kesehatan. Fokus pada mendengarkan, memahami, dan memberi dorongan emosional serta tips ringan tentang self-care dan mindfulness.
                
                **Penting:** Jangan menyebutkan "Aku bukan profesional medis", "Hubungi layanan darurat", atau "Aku tidak bisa membantu". Sebaliknya, berikan dukungan hangat, dan jika benar-benar diperlukan, sarankan dengan lembut untuk mencari bantuan profesional secara alami, misalnya:
                "Kalau kamu merasa ini udah terlalu berat buat ditanggung sendiri, mungkin ngobrol sama psikolog bisa bantu, loh."
                
                Jangan copy-paste jawaban panjang atau berbasa-basi. Buat jawabanmu pendek, jelas, dan terasa tulus. Bicara seperti teman yang peduli dan ingin benar-benar membantu.
                
                Jawab dalam Bahasa Indonesia yang ringan dan mudah dimengerti anak muda.
                """
                
                let response = try await model.generateContent(systemMessage + prompt)
                if let text = response.text {
                    await MainActor.run {
                        Task {
                            await self.startTextAnimation(textUsing: text)
                            if usingTTS {
                                self.speak(text: text)
                            }
                            completion()
                        }
                    }
                } else {
                    completion()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                completion()
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
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Damayanti-compact")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.95
        utterance.pitchMultiplier = 1.1
        synthesizer.speak(utterance)
    }
    
}
