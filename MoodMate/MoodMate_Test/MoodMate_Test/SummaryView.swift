//
//  SummaryView.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//
import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var dataManager: FeelingDataManager
    @State private var summary: String = "요약을 불러오려면 아래 버튼을 누르세요."
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("AI 감정 요약")
                .font(.title)
            
            ScrollView {
                Text(summary)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            if isLoading {
                ProgressView()
            } else {
                Button("요약 요청하기") {
                    isLoading = true
                    ChatGPTManager.shared.requestSummary(from: dataManager.entries) { result in
                        DispatchQueue.main.async {
                            summary = result ?? "요약 실패!"
                            isLoading = false
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }
}


#Preview {
    SummaryView()
}
