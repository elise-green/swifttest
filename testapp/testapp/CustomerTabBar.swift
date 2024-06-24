//
//  CustomerTabBar.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI

enum Tabs: Int{
    case home = 0
    case products = 1
    case scan = 2
}

struct CustomerTabBar: View {
    
    @Binding var selectedTab: Tabs
    var body: some View {
        HStack(alignment: .bottom, spacing: 200){
            
            
            Button {
                selectedTab = .home
            } label: {
            
                    VStack{
                        Image(systemName: "house")
                        Text("Home")
                    }

            }
           
            Button {
                selectedTab = .scan
            } label: {
                
                    VStack{
                        Image(systemName: "camera")
                        Text("Scan")
                    }


            }

        }
    

        Button {
            selectedTab = .products
        } label: {
            
            VStack{
                Image(systemName: "bag")
                Text("Products")
            }

        }
    }

    }


#Preview {
    CustomerTabBar(selectedTab: .constant(.home))
}
