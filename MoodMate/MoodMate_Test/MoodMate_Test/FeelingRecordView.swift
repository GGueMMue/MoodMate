//
//  FeelingRecordView.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import SwiftUI

struct FeelingRecordView: View {
    @EnvironmentObject var dataManager: FeelingDataManager
    
    @State private var selectedEmoji: String = "😊"
    @State private var note: String = ""
    @State private var selectedColor: Color = .yellow
    
    let emojiOptions = ["😊", "😢", "😡", "😴", "😍"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("오늘 기분은?")
                .font(.title)
            
            HStack {
                ForEach(emojiOptions, id: \.self) { emoji in
                    Text(emoji)
                        .font(.largeTitle)
                        .padding()
                        .background(selectedEmoji == emoji ? Color.gray.opacity(0.3) : Color.clear)
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedEmoji = emoji
                        }
                }
            }
            
            TextEditor(text: $note)
                .frame(height: 100)
                .border(Color.gray)
                .padding(.horizontal)
            
            ColorPicker("기분 색상", selection: $selectedColor)
                .padding()
            
            Button("기록 저장") {
                let hex = selectedColor.toHex()
                dataManager.addEntry(emoji: selectedEmoji, note: note, colorHex: hex)
                note = ""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    FeelingRecordView()
}
