//
//  DiscoverView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct DiscoverView: View {
    @State private var selectedIndex = 0
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var moodViewModel = MoodViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedIndex {
                case 0: HomeView().environmentObject(moodViewModel)
                case 1: NewsView()
                case 2: AIView()
                case 3: Text("Stats")
                case 4: SettingsView().environmentObject(authViewModel)
                default: HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            CustomTabBar(selectedIndex: $selectedIndex)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
