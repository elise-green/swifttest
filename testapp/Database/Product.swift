//  Product.swift
//  testapp
//
//  Created by Nadia Nafeesa on 18/8/2024.
//

import Foundation
import SwiftData

@Model
class Product: Identifiable {
    @Attribute(.unique) var id: UUID
    @Attribute var name: String
    @Attribute var productDescription: String
    @Attribute var suitableSkinType: [SkinType]
    @Attribute var purchaseLink: URL
    @Attribute var imageURL: URL  // Added imageURL attribute

    init(name: String, productDescription: String, suitableSkinType: [SkinType] = [], purchaseLink: URL, imageURL: URL) {
        self.id = UUID()
        self.name = name
        self.productDescription = productDescription
        self.suitableSkinType = suitableSkinType
        self.purchaseLink = purchaseLink
        self.imageURL = imageURL  // Initialize the imageURL
    }
}

