//
//  ContentViewTest.swift
//  testapp
//
//  Created by Nadia Nafeesa on 27/7/2024.
//


import SwiftUI
import SwiftData


struct ContentViewTest: View {
    // swift data stuff
    @Environment(\.modelContext) public var context
    
    // need to put @Query, but not working
    @Query
    public var items: [DataItem]
    
    
    @State var selectedTab: Tabs = .home
    var body: some View {
        

        }
    
    // swift data functions
    func addItem() {
        // create item
        let item = DataItem(name: "Test Item")
        // add the item to the data context
        context.insert(item)
    }
    
    func deleteItem( item: DataItem){
        context.delete(item)
    }
    }

#Preview {
    ContentViewTest()
}
