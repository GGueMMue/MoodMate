//
//  CalendarView.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var dataManager: FeelingDataManager
    
    var body: some View {
        List {
            ForEach(dataManager.entries.sorted(by: { $0.date > $1.date })) { entry in
                HStack {
                    Circle()
                        .fill(Color(hex: entry.colorHex))
                        .frame(width: 20, height: 20)
                    
                    Text(entry.emoji)
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading) {
                        Text(entry.note).lineLimit(1)
                        Text(entry.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: deleteEntry)
        }
        .navigationTitle("감정 기록 보기")
    }
    
    func deleteEntry(at offsets: IndexSet) {
        // 정렬된 리스트 기준으로 인덱스를 가져오므로 먼저 정렬해줘야 함
        let sortedEntries = dataManager.entries.sorted(by: { $0.date > $1.date })
        for index in offsets {
            if let originalIndex = dataManager.entries.firstIndex(where: { $0.id == sortedEntries[index].id }) {
                dataManager.entries.remove(at: originalIndex)
            }
        }
        dataManager.save()
    }
}

#Preview {
    CalendarView()
}
