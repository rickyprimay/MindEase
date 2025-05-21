//
//  DiscoverView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        TabView {
            Tab("Beranda", systemImage: "house") {
                HomeView()
            }
            Tab("Pengaturan", systemImage: "gearshape") {
                Text("Profile")
            }
        }
    }
}
