//
//  SettingsView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 25/05/25.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    let name = UserDefaults.standard.string(forKey: "userName") ?? ""
    let profileImageURL = UserDefaults.standard.string(forKey: "userProfileImage") ?? ""
    let email = UserDefaults.standard.string(forKey: "userEmail") ?? ""
    @State private var showLogoutConfirmation = false

    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.1)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                WebImage(url: URL(string: profileImageURL))
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding(.top, 32)

                VStack(spacing: 4) {
                    Text(name)
                        .font(AppFont.Poppins.bold(20))
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(email)
                            .font(AppFont.Poppins.regular(14))
                            .foregroundColor(.gray)
                    }
                }

                Button {
                    showLogoutConfirmation = true
                } label: {
                    Text("Log Out")
                        .font(AppFont.Poppins.regular(16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("PastelBlue"), Color.purple.opacity(0.6)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                }

                Spacer(minLength: 40)
            }
            .alert(isPresented: $showLogoutConfirmation) {
                Alert(
                    title: Text("Konfirmasi Logout"),
                    message: Text("Apakah Anda yakin ingin logout?"),
                    primaryButton: .destructive(Text("Logout"), action: {
                        authViewModel.logout()
                    }),
                    secondaryButton: .cancel(Text("Batal"))
                )
            }
        }
    }
}
