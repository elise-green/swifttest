//
//  User.swift
//  testapp
//
//  Created by Nadia Nafeesa on 28/7/2024.
// test

import Foundation
import SwiftData

@Model
class User: Identifiable {
    @Attribute(.unique) var id: UUID
    @Attribute var username: String
    @Attribute var email: String
    @Attribute var skinType: SkinType
    @Attribute var skinConcerns: [String]
    @Attribute var favoriteProducts: [String]
    @Attribute var acneCount: Int
//    @Attribute var acneLevel: [String]

    init(username: String, email: String, skinType: SkinType, skinConcerns: [String] = [], favoriteProducts: [String] = []) {
        self.id = UUID()
        self.username = username
        self.email = email
        self.skinType = skinType
        self.skinConcerns = skinConcerns
        self.favoriteProducts = favoriteProducts
        self.acneCount = 0
//        self.acneCount = [] // add logic to choose acne level from acne count
    }
}

enum SkinType: String, Codable {
    case oily = "Oily"
    case combination = "Combination"
    case normal = "Normal"

    var displayName: String {
        return self.rawValue
    }
    
    
}
