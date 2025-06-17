//
//  AddView.swift
//  MoodMate
//
//  Created by 지대한 on 6/17/25.
//

import SwiftUI

struct AddView: View {
    
    @State var textFieldValue: String = ""
    var body: some View {
        ScrollView{
            VStack {
                TextField("Enter your emotion here", text: $textFieldValue)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(12.5)
                
                Button(
                    action: {
                    
                    },
                    label: {
                        Text("Save".uppercased()).foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                )
            }
            .padding(16)
        }
        .navigationTitle("Add an Emotion 😍")
    }
}

#Preview {
    NavigationView {
        AddView()
    }
}
