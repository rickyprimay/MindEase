//
//  MoodImage.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 26/05/25.
//

import Foundation

struct MoodImage {
    static func imageName(for mood: String) -> String {
        switch mood.lowercased() {
        case "senang":
            return "Good"
        case "gembira":
            return "Joyful"
        case "sedih":
            return "Sad"
        case "bosan":
            return "Bored"
        case "marah":
            return "Angry"
        default:
            return "Neutral"
        }
    }
}
