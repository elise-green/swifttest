//
//  UserProfileView.swift
//  testapp
//
//  Created by Nadia Nafeesa on 28/7/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct UserProfileListView: View {
    
    // State to manage the selected tab
    @State private var selectedTab: Tabs = .profile
    
    // Sample dummy user data
    @State private var users = [
        User(
            username: "Nadia",
            email: "nadia@example.com",
            skinType: .oily,
            skinConcerns: ["Acne", "Redness", "Dehydration"],
            favoriteProducts: ["Cleanser", "Moisturizer", "Sunscreen"]
        ),
        User(
            username: "Alex",
            email: "alex@example.com",
            skinType: .combination,
            skinConcerns: ["Dryness", "Sensitivity"],
            favoriteProducts: ["Hydrating Serum", "Gentle Cleanser"]
        ),
        User(
            username: "Taylor",
            email: "taylor@example.com",
            skinType: .normal,
            skinConcerns: ["Fine Lines", "Dullness"],
            favoriteProducts: ["Night Cream", "Vitamin C Serum"]
        )
    ]

    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserProfileDetailView(user: user)) {
                    UserProfileRow(user: user)
                }
            }
            .navigationTitle("User Profiles")
        }
    }
}

struct UserProfileRow: View {
    var user: User

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.username)
                .font(.headline)
            Text("Skin Type: \(user.skinType.displayName)")
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

struct UserProfileDetailView: View {
    var user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Username: \(user.username)")
                .font(.headline)

            Text("Email: \(user.email)")
                .font(.subheadline)

            Text("Skin Type: \(user.skinType.displayName)")
                .font(.subheadline)

            Text("Skin Concerns:")
                .font(.subheadline)
            ForEach(user.skinConcerns, id: \.self) { concern in
                Text("- \(concern)")
                    .padding(.leading, 10)
            }

            Text("Favorite Products:")
                .font(.subheadline)
            ForEach(user.favoriteProducts, id: \.self) { product in
                Text("- \(product)")
                    .padding(.leading, 10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("User Profile")
    }
}

#Preview {
    UserProfileListView()
}
