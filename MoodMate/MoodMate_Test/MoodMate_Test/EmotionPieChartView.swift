//
//  EmotionPieChartView.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import SwiftUI
import DGCharts

struct EmotionPieChartView: UIViewRepresentable {
    let data: [String: Int]

    func makeUIView(context: Context) -> PieChartView {
        let chart = PieChartView()
        chart.legend.enabled = true
        chart.drawEntryLabelsEnabled = false
        chart.holeRadiusPercent = 0.4
        return chart
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        let entries = data.map { (emoji, count) -> PieChartDataEntry in
            PieChartDataEntry(value: Double(count), label: emoji)
        }
        
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = ChartColorTemplates.vordiplom() +
                         ChartColorTemplates.joyful() +
                         ChartColorTemplates.pastel()
        dataSet.valueFont = .systemFont(ofSize: 14, weight: .medium)
        dataSet.sliceSpace = 2

        uiView.data = PieChartData(dataSet: dataSet)
    }
}
