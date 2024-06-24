//
//  ContentView.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tabs = .home
    var body: some View {
        // Vertical stack layout
        
        
            VStack {
    
                ScrollView{
                    ForEach(1 ... 10, id: \.self) { i in
                        VStack{
                            Image("C-Firma")
                                .resizable()
                                .frame(width: 250.0, height: 300.0)
                                .imageScale(.small)
                                .cornerRadius(20)
                            
                            Link("Drunk Elephant C-Firma", destination: URL(string: "https://www.drunkelephant.ca/collections/best-sellers/c-firma-fresh-day-serum-812343034358.html?cgid=products-allproducts-bestsellers")!)
                            
                        }
                    }
                }
                Text("SkinCare")
                    .font(.title)
                    .foregroundColor(Color("AccentColor"))
                    .bold()
                    .padding()
                
            }
        Spacer()
        CustomerTabBar(selectedTab: $selectedTab)
        }
    }

#Preview {
    ContentView()
}
