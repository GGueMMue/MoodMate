//
//  FeelingEntry.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import Foundation

struct FeelingEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let emoji: String
    let note: String
    let colorHex: String
}
