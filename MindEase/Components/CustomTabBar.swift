//
//  CustomTabBar.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            CustomTabBarItem(icon: "house.fill", title: "Beranda", isSelected: selectedIndex == 0, isCenter: false) {
                selectedIndex = 0
            }
            Spacer()
            CustomTabBarItem(icon: "book.pages.fill", title: "Artikel", isSelected: selectedIndex == 1, isCenter: false) {
                selectedIndex = 1
            }
            Spacer()
            CustomTabBarItem(icon: "sparkles", title: "", isSelected: selectedIndex == 2, isCenter: true) {
                selectedIndex = 2
            }
            Spacer()
            CustomTabBarItem(icon: "chart.bar", title: "Status", isSelected: selectedIndex == 3, isCenter: false) {
                selectedIndex = 3
            }
            Spacer()
            CustomTabBarItem(icon: "gearshape", title: "Pengaturan", isSelected: selectedIndex == 4, isCenter: false) {
                selectedIndex = 4
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
        .padding(.top, 8)
        .background(
            Color.white
                .cornerRadius(32)
                .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 4)
        )
        .padding(.horizontal, 8)
    }
}
