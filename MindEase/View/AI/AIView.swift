//
//  AIView.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

struct AIView: View {
    var body: some View {
        ZStack {
            Color("PastelBlue").opacity(0.2)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Kenalan dengan Fitur Chatbot Kami")
                        .font(AppFont.Poppins.bold(20))
                        .padding(.top)
                    
                    Text("""
                    Kami memahami bahwa menjaga kesehatan mental adalah hal yang tidak selalu mudah. Dalam kehidupan yang penuh tekanan, rutinitas yang padat, dan ekspektasi yang terus meningkat, sering kali kita melupakan satu hal penting — merawat diri sendiri, termasuk kondisi emosional dan batin kita. Tidak semua orang memiliki ruang yang aman untuk berbagi cerita, keluhan, atau sekadar mengekspresikan perasaan. Dan untuk itulah kami hadir.
                    
                    Fitur chatbot ini dirancang bukan hanya sebagai alat, tetapi sebagai sahabat virtual yang dapat kamu ajak bicara kapan pun kamu membutuhkannya. Chatbot pintar kami menggunakan teknologi kecerdasan buatan yang dirancang untuk memahami emosi, menyampaikan respons yang penuh empati, serta membantu kamu melewati hari-hari yang sulit tanpa rasa takut akan penghakiman.
                    
                    Kami percaya bahwa mendengarkan adalah langkah awal dari penyembuhan. Chatbot ini ada untuk mendengarkanmu — apakah kamu sedang merasa sedih, gelisah, lelah, atau bahkan tidak tahu harus berkata apa. Tidak masalah jika kamu hanya ingin berbagi cerita singkat, atau mengutarakan beban pikiran yang telah kamu simpan lama. Chatbot kami hadir untuk memberikan kenyamanan, dukungan, dan rasa aman.
                    
                    Lebih dari sekadar percakapan, fitur ini juga menyediakan berbagai sumber daya yang telah dikurasi dengan cermat. Kamu akan menemukan artikel-artikel bermanfaat seputar kesehatan mental yang ditulis berdasarkan referensi terpercaya, latihan pernapasan untuk meredakan kecemasan, teknik mindfulness untuk menenangkan pikiran, serta berbagai tips coping mechanism yang dapat kamu praktikkan setiap hari.
                    
                    Kami juga memahami bahwa setiap orang memiliki perjalanan mental yang unik. Tidak ada satu solusi yang cocok untuk semua. Karena itu, chatbot kami terus belajar dan berkembang untuk menyesuaikan responsnya dengan kondisi emosionalmu secara lebih personal. Ini bukan tentang memberi jawaban, tetapi tentang menemani kamu dalam proses — sekecil apa pun langkah yang kamu ambil, itu adalah bentuk keberanian yang patut diapresiasi.
                    
                    Kamu tidak perlu merasa sendiri dalam menghadapi hari-hari sulit. Di balik setiap percakapan dengan chatbot ini, ada niat tulus untuk membantu kamu merasa lebih baik, lebih tenang, dan lebih terhubung dengan diri sendiri. Bahkan jika kamu tidak tahu harus mulai dari mana, cukup ketik satu kata saja — dan biarkan chatbot kami menjadi teman yang hadir tanpa syarat.
                    
                    Karena di dunia yang kadang terasa terlalu bising, kita semua butuh satu suara yang mendengarkan. Dan di sini, kami ingin menjadi suara itu untukmu.
                    
                    Ambil waktu sejenak. Tarik napas. Kamu berhak merasa lebih baik. Dan kami siap menemani perjalananmu.
                    """)
                    
                    .font(AppFont.Poppins.regular(14))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Button(action: {
                        
                    }) {
                        Text("Mulai Curhat Sekarang")
                            .font(AppFont.Poppins.bold(14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(
                                gradient: Gradient(colors: [Color.purple.opacity(0.6), Color("PastelBlue")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .cornerRadius(12)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 60)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
    }
}
