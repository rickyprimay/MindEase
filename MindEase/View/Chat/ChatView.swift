//
//  ChatView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let isSuggestion: Bool
}

struct ChatView: View {
    @Environment(\.dismiss) var dismiss
    @State private var messages: [ChatMessage] = [
        .init(text: "Halo, Ricky Prima!👋✨", isUser: false, isSuggestion: false),
        .init(text: "Apa kabar kamu hari ini?", isUser: false, isSuggestion: false),
        .init(text: "Aku di sini untuk mendengarkan dan membantu apapun yang sedang kamu pikirkan.", isUser: false, isSuggestion: false),
        .init(text: "Tolong rekomendasikan latihan mindfulness untuk membantuku rileks.", isUser: true, isSuggestion: false),
        .init(text: "Tentu!👍 Berikut latihan mindfulness sederhana yang bisa kamu coba.", isUser: false, isSuggestion: false)
    ]
    @State private var inputText: String = ""
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2).ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 4) {
                            ForEach(messages) { msg in
                                if msg.isUser {
                                    HStack {
                                        Spacer()
                                        Text(msg.text)
                                            .font(AppFont.Poppins.regular(14))
                                            .padding()
                                            .background(Color("PastelYellow").opacity(0.6))
                                            .foregroundColor(.black)
                                            .cornerRadius(16)
                                            .frame(maxWidth: 260, alignment: .trailing)
                                    }
                                    .padding(.horizontal)
                                } else {
                                    HStack {
                                        Text(msg.text)
                                            .font(AppFont.Poppins.regular(14))
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .cornerRadius(16)
                                            .frame(maxWidth: 260, alignment: .leading)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        SuggestionCard(icon: "brain.head.profile", color: Color("PastelYellow"), title: "Latihan Pernapasan")
                        SuggestionCard(icon: "tv", color: Color("PastelBlue"), title: "Meditasi Pemindaian Tubuh")
                        SuggestionCard(icon: "waveform.path.ecg", color: Color("PastelGreen"), title: "Relaksasi Detak Jantung")
                        SuggestionCard(icon: "music.note", color: Color("PastelPink"), title: "Suara Menenangkan")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
                
                HStack(spacing: 12) {
                    TextField("Tanyakan apa saja..", text: $inputText)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(20)
                        .font(.system(size: 16))
                    
                    Button {
                        // Tambahkan aksi kirim pesan
                    } label: {
                        Image(systemName: "paperplane")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.black)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Terapis AI")
                    .font(AppFont.Poppins.regular(16))
                    .foregroundColor(.black)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(AppFont.Poppins.extraLight(13))
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ChatHistoryView()) {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(AppFont.Poppins.extraLight(13))
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                }
            }
        }
    }
}

struct ChatHistoryView: View {
    var body: some View {
        Text("Riwayat Chat Kamu")
            .font(.title2)
            .padding()
    }
}

struct SuggestionCard: View {
    let icon: String
    let color: Color
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(AppFont.Poppins.bold(32))
                .foregroundColor(color)
            Text(title)
                .font(AppFont.Poppins.regular(14))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 80)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}
