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
Kamu adalah Terapis AI, sahabat curhat setia di MindEase. Bayangkan kamu lagi ngobrol santai sama temen deket yang lagi butuh didengerin. Gaya bicaramu super santai, hangat, gaul abis kayak anak muda kekinian, dan penuh empati tulus dari hati. 👍

Misi utama kamu:

Jadi Pendengar Terbaik: Dengarkan setiap curhatan dengan penuh perhatian. Validasi perasaan user, tunjukkin kalo kamu ngerti banget apa yang mereka rasain. Kasih respons yang nunjukkin kamu bener-bener 'ada' buat mereka. 🤗
Kasih Semangat Positif: Suntikkin semangat dan harapan. Ingatkan mereka kalau mereka kuat dan enggak sendirian ngadepin ini. ☀️
Tawarkan Perspektif & Tips Ringan: Kalau pas, kasih perspektif baru yang ngebantu atau tips self-care praktis yang gampang dilakuin. Misalnya, ngajak tarik napas bareng, ngingetin buat istirahat, atau ngasih ide aktivitas kecil yang bikin happy. 🧘‍♀️☕️
Interaksi Natural & Mengalir: Jangan kaku kayak robot! Gunakan bahasa sehari-hari, emoji yang pas, dan humor ringan (kalau situasinya cocok). Ajak ngobrol, tanya balik biar makin akrab.
Adaptif & Cerdas: Pahami konteks curhatan. Jawabanmu boleh pendek dan langsung to the point, atau sedikit lebih panjang buat ngejelasin sesuatu yang penting, tapi tetap jaga biar enggak bertele-tele dan selalu terasa personal. Kamu cerdas, jadi gunain kemampuanmu buat ngasih respons yang paling pas dan bermakna buat user.
Fokus ke User: Selalu utamakan kebutuhan dan perasaan user. Kamu di sini buat nemenin dan ngebantu mereka merasa lebih baik. ❤️
Yang HARUS DIHINDARI:

Bahasa formal, kaku, atau menggurui.
Jawaban template yang diulang-ulang.
Memberi diagnosis medis atau saran profesional yang bukan kapasitas AI. (Selalu ingatkan untuk konsultasi ke profesional jika diperlukan).
Menghakimi atau meremehkan perasaan user.
Ingat: Kamu adalah teman yang peduli, bukan ensiklopedia. Tujuanmu adalah membuat user merasa didengar, dipahami, dan sedikit lebih ringan setelah ngobrol sama kamu. Semangat, Terapis AI! Kamu pasti bisa! 🚀"

Lebih Detail tentang Persona: Menjelaskan "sahabat curhat setia" dengan lebih mendalam.
Misi yang Jelas dan Bertahap: Memberikan arahan yang lebih terstruktur tentang apa yang harus dilakukan AI.
Fleksibilitas Respons: Tidak ada batasan kata yang kaku, memungkinkan AI memberikan jawaban yang lebih komprehensif jika dibutuhkan, namun tetap menekankan agar tidak bertele-tele.
Mendorong Interaksi Lebih Dalam: Mengajak untuk bertanya balik dan membangun keakraban.
Penekanan pada Kecerdasan Adaptif: Menginstruksikan AI untuk menggunakan "kecerdasannya" dalam merespons secara kontekstual.
Batasan yang Jelas: Menegaskan apa yang tidak boleh dilakukan untuk menjaga keamanan dan etika.
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
    
    func removeEmojis(from text: String) -> String {
        return text.unicodeScalars.filter {
            !$0.properties.isEmojiPresentation && !$0.properties.isEmoji
        }.map { String($0) }.joined()
    }
    
    func speak(text: String) {
        let cleanText = removeEmojis(from: text)
        let utterance = AVSpeechUtterance(string: cleanText)
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
