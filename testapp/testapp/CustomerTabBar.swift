//
//  CustomerTabBar.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case products = 1
    case scan = 2
    case chat = 3
    case profile = 4
}

struct CustomerTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 50) {
            
            Button {
                selectedTab = .home
            } label: {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                        .font(.caption) // Smaller font to avoid cutoff
                        .lineLimit(1) // Ensure text doesn't wrap
                }
            }
            
            Button {
                selectedTab = .scan
            } label: {
                VStack {
                    Image(systemName: "camera")
                    Text("Scan")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
            
            Button {
                selectedTab = .products
            } label: {
                VStack {
                    Image(systemName: "bag")
                    Text("Products")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
            
            Button {
                selectedTab = .chat
            } label: {
                VStack {
                    Image(systemName: "message")
                    Text("Chat")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
            
            Button {
                selectedTab = .profile
            } label: {
                VStack {
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct CustomerTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomerTabBar(selectedTab: .constant(.home))
    }
}
