//
//  DiscoverView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct DiscoverView: View {
    @State private var selectedIndex = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedIndex {
                case 0: HomeView()
                case 1: Text("Explore")
                case 2: NavigationView { AIView() }
                case 3: Text("Stats")
                case 4: Text("Setting")
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
