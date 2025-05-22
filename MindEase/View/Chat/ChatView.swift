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
    @State private var messages: [ChatMessage] = [
        .init(text: "Hello, Summer 👋✨", isUser: false, isSuggestion: false),
        .init(text: "How are you feeling today?", isUser: false, isSuggestion: false),
        .init(text: "I'm here to listen and help you with anything on your mind.", isUser: false, isSuggestion: false),
        .init(text: "Please recommend me mindfulness exercise to help me relax.", isUser: true, isSuggestion: false),
        .init(text: "Sure!👍 Here’s a simple mindfulness exercise you can try.", isUser: false, isSuggestion: false)
    ]
    @State private var inputText: String = ""
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 4) {
                            ForEach(messages) { msg in
                                if msg.isUser {
                                    HStack {
                                        Spacer()
                                        Text(msg.text)
                                            .padding()
                                            .background(Color("PastelYellow"))
                                            .foregroundColor(.black)
                                            .cornerRadius(16)
                                            .frame(maxWidth: 260, alignment: .trailing)
                                    }
                                    .padding(.horizontal)
                                } else {
                                    HStack {
                                        Text(msg.text)
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
                            
                            HStack(spacing: 16) {
                                SuggestionCard(
                                    icon: "brain.head.profile",
                                    color: Color("PastelYellow"),
                                    title: "Breathing Exercise"
                                )
                                SuggestionCard(
                                    icon: "tv",
                                    color: Color("PastelBlue"),
                                    title: "Body Scan Meditation"
                                )
                            }
                            .padding(.top, 8)
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 16)
                    }
                }
                
                // Input bar
                HStack(spacing: 12) {
                    TextField("Ask me anything", text: $inputText)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(20)
                        .font(.system(size: 16))
                    
                    Button {
                        // Action send
                    } label: {
                        Image(systemName: "mic.fill")
                            .foregroundColor(Color("PastelBlue"))
                            .font(.system(size: 22))
                    }
                    
                    Button {
                        // Action send
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("PastelBlue"))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemGroupedBackground).opacity(0.9))
            }
        }
    }
}

struct SuggestionCard: View {
    let icon: String
    let color: Color
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 80)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}
