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
    
    let name = UserDefaults.standard.string(forKey: "userName") ?? ""
    let profileImageURL = UserDefaults.standard.string(forKey: "userProfileImage") ?? ""
    @EnvironmentObject var moodViewModel: MoodViewModel
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()
            
            if moodViewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Memuat data...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .font(AppFont.Poppins.bold(14))
                    Spacer()
                }
            } else {
                
                ScrollView {
                    VStack {
                        HStack {
                            WebImage(url: URL(string: profileImageURL))
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(Date().greetingForCurrentHour())
                                    .font(AppFont.Poppins.extraLight(14))
                                Text(name)
                                    .font(AppFont.Poppins.regular(16))
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 2)
                        
                        if let todayMood = moodViewModel.todayMood {
                            VStack(spacing: 16) {
                                HStack {
                                    Image(MoodImage.imageName(for: todayMood))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    
                                    Text("Kamu hari ini merasa \(todayMood)")
                                        .font(AppFont.Poppins.bold(16))
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 4)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
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
                        } else {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Bagaimana perasaanmu hari ini?")
                                    .font(AppFont.Poppins.bold(18))
                                    .padding(.bottom)
                                
                                HStack(spacing: 22) {
                                    MoodButton(image: "Good", label: "Senang") {
                                        moodViewModel.selectedMood = "Senang"
                                        moodViewModel.note = ""
                                        moodViewModel.showNotePopup = true
                                    }
                                    MoodButton(image: "Joyful", label: "Gembira") {
                                        moodViewModel.selectedMood = "Gembira"
                                        moodViewModel.note = ""
                                        moodViewModel.showNotePopup = true
                                    }
                                    MoodButton(image: "Sad", label: "Sedih") {
                                        moodViewModel.selectedMood = "Sedih"
                                        moodViewModel.note = ""
                                        moodViewModel.showNotePopup = true
                                    }
                                    MoodButton(image: "Bored", label: "Bosan") {
                                        moodViewModel.selectedMood = "Bosan"
                                        moodViewModel.note = ""
                                        moodViewModel.showNotePopup = true
                                    }
                                    MoodButton(image: "Angry", label: "Marah") {
                                        moodViewModel.selectedMood = "Marah"
                                        moodViewModel.note = ""
                                        moodViewModel.showNotePopup = true
                                    }
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
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                        
                        MoodJourneyCard(progress: moodViewModel.calculateMoodScoreNormalized())
                            .padding(.top, 24)
                            .frame(height: 220)
                        
                        Spacer(minLength: 32)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .onAppear {
                        guard !hasAppeared else { return }
                        hasAppeared = true

                        if moodViewModel.todayMood == nil {
                            moodViewModel.checkMoodForToday { success in
                                print("Mood loaded:", moodViewModel.todayMood ?? "None")
                            }
                        }

                        moodViewModel.fetchWeeklyMoods { success in
                            if success {
                                let progress = moodViewModel.calculateMoodScoreNormalized()
                                print("Weekly mood score normalized: \(progress)")
                            }
                        }
                    }
                }
            }
            if moodViewModel.showNotePopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.2), value: moodViewModel.showNotePopup)
                
                MoodNotePopup(
                    note: $moodViewModel.note,
                    mood: moodViewModel.selectedMood,
                    onSave: {
                        moodViewModel.saveMood()
                        moodViewModel.showNotePopup = false
                        withAnimation {
                            moodViewModel.moodSaved = true
                        }
                    },
                    onCancel: {
                        moodViewModel.showNotePopup = false
                    }
                )
                .transition(.scale)
                .animation(.spring(), value: moodViewModel.showNotePopup)
            }
        }
    }
}
