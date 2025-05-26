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
    @StateObject var newsViewModel = NewsViewModel()

    var views: [AnyView] {
        [
            AnyView(HomeView().environmentObject(moodViewModel)),
            AnyView(NewsView().environmentObject(newsViewModel)),
            AnyView(AIView()),
            AnyView(StatsView().environmentObject(moodViewModel)),
            AnyView(SettingsView().environmentObject(authViewModel))
        ]
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            views[selectedIndex]
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar(selectedIndex: $selectedIndex)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
