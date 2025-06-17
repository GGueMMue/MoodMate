//
//  ListView.swift
//  MoodMate
//
//  Created by 지대한 on 6/17/25.
//

import SwiftUI

struct ListView: View {
    
    @State var items: [String] = [
        "First",
        "Sec",
        "Third"
    ]
    
    var body: some View {
    
        List{
            ForEach(items, id: \.self){
                items in ListRowView(title: items)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("MoodMate 🌫️")
        .navigationBarItems(leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
            )
    }
}

#Preview {
    NavigationView {
        ListView()
    }
}
