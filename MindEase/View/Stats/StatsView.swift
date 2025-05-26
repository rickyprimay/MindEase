//
//  StatsView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 26/05/25.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var moodViewModel: MoodViewModel
    
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {                    
                    if moodViewModel.weeklyMoodData.isEmpty {
                        Text("Belum ada data mood.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(moodViewModel.allMoodData.sorted(by: { $0.key > $1.key }), id: \.key) { date, mood in
                            HStack(spacing: 16) {
                                Image(MoodImage.imageName(for: mood))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(date)
                                        .font(AppFont.Poppins.regular(14))
                                    Text(mood)
                                        .font(AppFont.Poppins.extraLight(12))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 32)
                }
            }
        }
        .navigationTitle("Status Mood")
        .onAppear {
            moodViewModel.fetchAllMoods { success in
                if success {  }
            }
        }
    }
}
