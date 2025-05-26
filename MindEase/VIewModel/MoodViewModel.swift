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
    @Published var weeklyMoodData: [String: String] = [:]
    @Published var allMoodData: [String: String] = [:]
    @Published var isLoading: Bool = false
    
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
        
        self.isLoading = true
        let todayDate = Date().formattedDateString()
        
        db.collection("moods")
            .document(userId)
            .collection("entries")
            .document(todayDate)
            .getDocument { document, error in
                DispatchQueue.main.async {
                    if let document = document, document.exists, let data = document.data(),
                       let mood = data["mood"] as? String {
                        self.todayMood = mood
                    } else {
                        self.todayMood = nil
                    }
                    self.isLoading = false
                    completion(true)
                }
            }
    }
    
    func fetchAllMoods(completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        db.collection("moods")
            .document(userId)
            .collection("entries")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching all moods: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                var tempData: [String: String] = [:]
                snapshot?.documents.forEach { doc in
                    let data = doc.data()
                    if let mood = data["mood"] as? String,
                       let timestamp = data["timestamp"] as? Timestamp {
                        let date = timestamp.dateValue()
                        let dateString = date.formattedDateString()
                        tempData[dateString] = mood
                    }
                }
                DispatchQueue.main.async {
                    self.allMoodData = tempData
                    completion(true)
                }
            }
    }
    
    func fetchWeeklyMoods(completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        self.isLoading = true
        let calendar = Calendar.current
        let today = Date()

        let group = DispatchGroup()
        var tempData: [String: String] = [:]

        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let dateString = date.formattedDateString()
                group.enter()
                db.collection("moods")
                    .document(userId)
                    .collection("entries")
                    .document(dateString)
                    .getDocument { document, error in
                        if let document = document, document.exists,
                           let data = document.data(),
                           let mood = data["mood"] as? String {
                            tempData[dateString] = mood
                        }
                        group.leave()
                    }
            }
        }

        group.notify(queue: .main) {
            self.weeklyMoodData = tempData
            self.isLoading = false
            completion(true)
        }
    }
    
    func calculateMoodScoreNormalized() -> Double {
        let moodScores: [String: Int] = [
            "Gembira": 4,
            "Senang": 4,
            "Bosan": 2,
            "Sedih": 1,
            "Marah": 1
        ]
        
        let moods = weeklyMoodData.values
        guard !moods.isEmpty else { return 0.25 }
        
        let totalScore = moods.reduce(0) { $0 + (moodScores[$1] ?? 0) }
        let maxScore = moods.count * 4
        
        let normalized = Double(totalScore) / Double(maxScore)
        
        return max(normalized, 0.25)
    }
    
}
