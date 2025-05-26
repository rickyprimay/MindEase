//
//  Extensions+Date.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import SwiftUI

extension Date {
    func greetingForCurrentHour() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        
        switch hour {
        case 5..<11:
            return "Selamat Pagi"
        case 11..<15:
            return "Selamat Siang"
        case 15..<18:
            return "Selamat Sore"
        case 18..<22:
            return "Selamat Malam"
        default:
            return "Selamat Tidur"
        }
    }
    
    func formattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
