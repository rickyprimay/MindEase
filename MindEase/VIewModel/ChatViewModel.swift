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
    
    @Published var isSpeaking: Bool = false
    private var animationTask: Task<Void, Never>? = nil

    @Published var chatHistory: [String] = []
    
    let model = GenerativeModel(
        name: "gemini-1.5-flash-latest",
        apiKey: "AIzaSyCMZoLNkDoL6Gc-1Ae1gt8sIeBoqYkZBqM"
    )
    
    private let systemMessage = """
Kamu adalah AI teman curhat di MindEase. Jawab dengan gaya santai, hangat, dan penuh empati, seperti sahabat yang peduli. Gunakan bahasa gaul anak muda, boleh pakai emoji, dan jangan lebih dari 20 kata. Fokus pada mendengarkan, memberi semangat, dan tips ringan self-care. Jangan terlalu formal atau seperti robot. Jawaban harus singkat, tulus, dan terasa dekat.
"""

    private func buildPrompt(userPrompt: String) -> String {
        let historyString = chatHistory.joined(separator: "\n")
        return """
        \(systemMessage)
        Riwayat obrolan:
        \(historyString)
        User: \(userPrompt)
        """
    }

    func addToHistory(_ message: String) {
        chatHistory.append(message)
        if chatHistory.count > 6 {
            chatHistory.removeFirst(chatHistory.count - 6)
        }
    }
    
    func sendPromptToGemini(prompt: String, usingTTS: Bool, completion: @escaping () -> Void) {
        isSpeaking = true
        Task {
            do {
                let promptToSend = buildPrompt(userPrompt: prompt)
                let response = try await model.generateContent(promptToSend)
                if let text = response.text {
                    await MainActor.run {
                        self.addToHistory("User: \(prompt)")
                        self.addToHistory("AI: \(text)")
                    }
                    if usingTTS {
                        await MainActor.run {
                            self.speak(text: text)
                        }
                    }
                    animationTask = Task {
                        await self.startTextAnimation(textUsing: text)
                        await MainActor.run {
                            self.isSpeaking = false
                            completion()
                        }
                    }
                } else {
                    await MainActor.run {
                        self.isSpeaking = false
                        completion()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                await MainActor.run {
                    self.isSpeaking = false
                    completion()
                }
            }
        }
    }
    
    func stopAll() {
        stopSpeaking()
        animationTask?.cancel()
        isAnimatingText = false
        isSpeaking = false
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
    
    func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
}
