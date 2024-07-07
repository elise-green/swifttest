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
                }
            }
            
            Button {
                selectedTab = .scan
            } label: {
                VStack {
                    Image(systemName: "camera")
                    Text("Scan")
                }
            }
            
            Button {
                selectedTab = .products
            } label: {
                VStack {
                    Image(systemName: "bag")
                    Text("Products")
                }
            }
            
            Button {
                selectedTab = .chat
            } label: {
                VStack {
                    Image(systemName: "message")
                    Text("Chat")
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
