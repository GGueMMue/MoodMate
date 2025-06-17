//
//  ListRowView.swift
//  MoodMate
//
//  Created by 지대한 on 6/17/25.
//

import SwiftUI

struct ListRowView: View {
    let title: String
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle")
            Text(title)
            Spacer()
        }
    }
}

#Preview {
    ListRowView(title: "Test Title")
}
