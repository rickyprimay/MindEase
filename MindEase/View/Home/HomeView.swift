//
//  HomeView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var profileImageURL: URL?
    @State private var displayName: String = ""
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    HStack {
                        WebImage(url: profileImageURL)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(Date().greetingForCurrentHour())
                                .font(AppFont.Poppins.extraLight(14))
                            Text(displayName)
                                .font(AppFont.Poppins.regular(16))
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 2)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Bagaimana perasaanmu hari ini?")
                            .font(AppFont.Poppins.bold(18))
                            .padding(.bottom)
                        
                        HStack(spacing: 24) {
                            MoodButton(emoji: "😊", label: "Good")
                            MoodButton(emoji: "🥰", label: "Joyful")
                            MoodButton(emoji: "😢", label: "Sad")
                            MoodButton(emoji: "😐", label: "Bored")
                            MoodButton(emoji: "😡", label: "Angry")
                        }
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 16)
                    .background(
                        Color.white
                            .cornerRadius(24)
                            .shadow(color: Color.black.opacity(0.07), radius: 8, x: 4, y: 4)
                    )
                    .padding(.vertical, 12)
                    .padding(.bottom, 20)
                    
                    MoodJourneyCard(progress: 0.82)
                        .padding(.top, 24)
                        .frame(height: 220)
                        
                    Spacer(minLength: 32)
                }
                .padding(.horizontal)
                .padding(.top)
                .onAppear {
                    loadUserData()
                }
            }
        }
    }
    
    func loadUserData() {
        if let user = Auth.auth().currentUser {
            self.profileImageURL = user.photoURL
            self.displayName = user.displayName ?? "Guest"
        }
    }
}
