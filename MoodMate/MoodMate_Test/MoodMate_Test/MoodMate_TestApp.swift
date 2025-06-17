//
//  MoodMate_TestApp.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import SwiftUI

@main
struct MoodMate_TestApp: App {
    @StateObject var dataManager = FeelingDataManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                FeelingRecordView()
                    .tabItem {
                        Label("기록", systemImage: "pencil")
                    }
                
                NavigationView {
                    CalendarView()
                }
                .tabItem {
                    Label("캘린더", systemImage: "calendar")
                }
                
                SummaryView()
                    .tabItem {
                        Label("요약", systemImage: "text.bubble")
                    }
                StatsView()
                    .tabItem {
                        Label("통계", systemImage: "chart.pie.fill")
                    }
            }
            .environmentObject(dataManager)
        }
    }
    
    
}
