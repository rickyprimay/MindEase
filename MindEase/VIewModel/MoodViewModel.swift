//
//  MoodViewModel.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 26/05/25.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MoodViewModel: ObservableObject {
    @Published var selectedMood: String = ""
    @Published var note: String = ""
    @Published var showNotePopup: Bool = false
    @Published var moodSaved: Bool = false
    @Published var todayMood: String? = nil
    
    private let db = Firestore.firestore()
    
    func saveMood() {
        guard let user = Auth.auth().currentUser else { return }
        
        let todayDate = Date().formattedDateString()
        let data: [String: Any] = [
            "user_id": user.uid,
            "mood": selectedMood,
            "note": note,
            "timestamp": Timestamp(date: Date())
        ]
        
        db.collection("moods")
            .document(user.uid)
            .collection("entries")
            .document(todayDate)
            .setData(data) { [weak self] error in
                if let error = error {
                    print("Error saving mood: \(error.localizedDescription)")
                } else {
                    print("Mood saved successfully!")
                    DispatchQueue.main.async {
                        self?.moodSaved = true
                        self?.todayMood = self?.selectedMood
                    }
                }
            }
    }
    
    
    func checkMoodForToday(completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let todayDate = Date().formattedDateString()
        let db = Firestore.firestore()
        
        db.collection("moods")
            .document(userId)
            .collection("entries")
            .document(todayDate)
            .getDocument { document, error in
                if let document = document, document.exists, let data = document.data(),
                   let mood = data["mood"] as? String {
                    DispatchQueue.main.async {
                        self.todayMood = mood
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.todayMood = nil
                        completion(false)
                    }
                }
            }
    }
}
