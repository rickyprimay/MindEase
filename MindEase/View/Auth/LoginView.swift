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
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 0.5)
                )
                .padding(.horizontal, 32)
            }
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
