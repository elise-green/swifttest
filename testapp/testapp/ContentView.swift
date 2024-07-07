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
                switch selectedTab {
                case .home:
                    HomeView()
                case .products:
                    ProductView()
                case .chat:
                    ChatView()
                case .scan:
                    CameraView()
                }
                
            }
        Spacer()
        CustomerTabBar(selectedTab: $selectedTab)
        }
    }

#Preview {
    ContentView()
}
