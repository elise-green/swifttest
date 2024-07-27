//
//  testappApp.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//
import SwiftUI
import SwiftData

@main
struct testappApp: App {
    // SwiftData container setup
    let container: ModelContainer = {
            let schema = Schema([User.self]) // Include User model in the schema
            let container = try! ModelContainer(for: schema, configurations: [])
            return container
        }()

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .modelContainer(container) // Attach the container to the view hierarchy
            }
        }
}

