//
//  ContentView.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext)  var context: ModelContext
    
    // Correct usage of @Query to fetch User data
    @Query private var users: [User]

    @State private var selectedTab: Tabs = .home

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
            }
            Spacer()
            CustomerTabBar(selectedTab: $selectedTab)
        }
        .onAppear {
            addDummyUsers()
        }
    }

    private func addDummyUsers() {
        let sampleUsers = [
            User(username: "Nadia", email: "nadia@example.com", skinType: .oily, skinConcerns: ["Acne"], favoriteProducts: ["Cleanser"]),
            User(username: "Alex", email: "alex@example.com", skinType: .combination, skinConcerns: ["Dryness"], favoriteProducts: ["Hydrating Serum"]),
            User(username: "Taylor", email: "taylor@example.com", skinType: .normal, skinConcerns: ["Fine Lines"], favoriteProducts: ["Night Cream"])
        ]
        for user in sampleUsers {
            context.insert(user)
        }
    }
}

#Preview {
    ContentView()
}
