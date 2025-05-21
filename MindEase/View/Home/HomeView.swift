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
        ScrollView{
            VStack {
                HStack {
                    WebImage(url: profileImageURL)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Good Afternoon")
                            .font(AppFont.Poppins.extraLight(14))
                        Text(displayName)
                            .font(AppFont.Poppins.regular(16))
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
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
                .padding(.top, 12)
                
                GeometryReader { geo in
                                    MoodJourneyCard(
                                        progress: 0.82,
                                        parallaxOffset: (geo.frame(in: .global).minY - 100) / 10
                                    )
                                    .padding(.top, 24)
                                }
                                .frame(height: 220)
                
                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                loadUserData()
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
