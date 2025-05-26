//
//  MoodNotePopup.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 26/05/25.
//

import SwiftUI

struct MoodNotePopup: View {
    @Binding var note: String
    var mood: String
    var onSave: () -> Void
    var onCancel: () -> Void
    
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text("Catatan untuk Mood \(mood)")
                .font(AppFont.Poppins.bold(14))
                .multilineTextAlignment(.center)
            
            TextEditor(text: $note)
                .padding()
                .frame(height: 120)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 1)
                )

            HStack(spacing: 16) {
                Button(action: {
                    hideKeyboard()
                    onCancel()
                }) {
                    Text("Batal")
                        .font(AppFont.Poppins.regular(12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }

                Button(action: {
                    hideKeyboard()
                    onSave()
                }) {
                    Text("Simpan")
                        .font(AppFont.Poppins.regular(12))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("PastelBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(.horizontal, 32)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
