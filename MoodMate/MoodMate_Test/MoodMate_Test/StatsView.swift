//
//  StatsView.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dataManager: FeelingDataManager
    
    var body: some View {
        VStack {
            Text("감정 통계")
                .font(.title)
                .padding(.top)

            if dataManager.entries.isEmpty {
                Text("기록된 감정이 없습니다.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                EmotionPieChartView(data: dataManager.emotionDistribution())
                    .frame(height: 300)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    StatsView()
}
