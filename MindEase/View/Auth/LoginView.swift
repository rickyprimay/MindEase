//
//  LoginView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            Image("BgLogin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 40)
                
                Text("Selamat Datang di MindEase")
                    .font(AppFont.Poppins.bold(16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                Text("Temukan suasana hati anda di MindEase")
                    .font(AppFont.Poppins.regular(14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.top, 4)
                
                Text("Kami membantu anda melacak, menganalisis, dan meningkatkan kesehatan emosional Anda di setiap langkahnya")
                    .font(AppFont.Poppins.regular(12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.top, -6)
                
                Spacer()
                
                Button {
                    authViewModel.googleSignIn()
                } label: {
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Text("Sign in with Google")
                            .font(AppFont.Poppins.regular(14))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 0.5)
                    )
                    .padding(.horizontal, 32)
                }
                .padding(.bottom, 60)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: .infinity)
        }
    }
}
