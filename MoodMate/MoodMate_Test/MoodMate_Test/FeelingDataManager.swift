//
//  FeelingDataManager.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import Foundation

class FeelingDataManager: ObservableObject {
    @Published var entries: [FeelingEntry] = []
    
    private let key = "FeelingEntries"
    
    init() {
        load()
    }
    
    func addEntry(emoji: String, note: String, colorHex: String) {
        let newEntry = FeelingEntry(id: UUID(), date: Date(), emoji: emoji, note: note, colorHex: colorHex)
        entries.append(newEntry)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([FeelingEntry].self, from: data) {
            entries = decoded
        }
    }
    
    func emotionDistribution() -> [String: Int] {
        var countDict: [String: Int] = [:]
        
        for entry in entries {
            countDict[entry.emoji, default: 0] += 1
        }
        return countDict
    }
}
