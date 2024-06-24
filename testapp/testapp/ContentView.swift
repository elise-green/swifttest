//
//  ContentView.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Vertical stack layout
     
       
            VStack {
                Button("Tap on Me") {
                    print("Hello")
                }
                ScrollView{
                    ForEach(1 ... 10, id: \.self) { i in
                        Image("Plant")
                            .resizable()
                            .frame(width: 200.0, height: 300.0)
                            .imageScale(.small)
                            .cornerRadius(20)
                                        }
                }
                Text("SkinCare")
                    .font(.title)
                    .foregroundColor(Color("AccentColor"))
                    .bold()
                    .padding()
                
            }
            .padding()
        }
    }

#Preview {
    ContentView()
}
