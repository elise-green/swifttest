//
//  ContentView.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context: ModelContext
    
    // Query for Users and Products
    @Query private var users: [User]
    @Query private var products: [Product]
    
    @State private var selectedTab: Tabs = .home
    
    // bottom tab bar
    var body: some View {
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
            case .profile:
                UserProfileListView()
            }
            Spacer()
            CustomerTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ContentView()
}
