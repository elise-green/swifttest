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
    let container: ModelContainer
    
    init() {
        // Initialize the container
        let mySchema = Schema([User.self, Product.self]) // Include both User and Product models in the schema
        container = try! ModelContainer(for: mySchema)
        
        // Initialize sample data
        addSampleData()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container) // Attach the container to the view hierarchy
        }
    }

    private func addSampleData() {
        // Perform context operations on the main thread
        Task { @MainActor in
            let context = container.mainContext

            addDummyUsers(to: context)
            addDummyProducts(to: context)
        }
    }

    private func addDummyUsers(to context: ModelContext) {
        let sampleUsers = [
            User(username: "Nadia", email: "nadia@example.com", skinType: .oily, skinConcerns: ["Acne"], favoriteProducts: ["Cleanser"]),
            User(username: "Alex", email: "alex@example.com", skinType: .combination, skinConcerns: ["Dryness"], favoriteProducts: ["Hydrating Serum"]),
            User(username: "Taylor", email: "taylor@example.com", skinType: .normal, skinConcerns: ["Fine Lines"], favoriteProducts: ["Night Cream"])
        ]
        for user in sampleUsers {
            context.insert(user)
        }
        try? context.save() // Ensure changes are saved
    }

    private func addDummyProducts(to context: ModelContext) {
        let sampleProducts = [
            Product(
                name: "Neutrogena Hydro Boost Water Gel",
                productDescription: "This water gel provides intense hydration with hyaluronic acid, ideal for normal skin. It absorbs quickly and is oil-free and non-comedogenic.",
                suitableSkinType: [.normal],
                purchaseLink: URL(string: "https://www.neutrogena.com/products/skincare/neutrogena-hydro-boost-water-gel-with-hyaluronic-acid/6811047.html")!,
                imageURL: URL(string: "https://ntg-catalog.imgix.net/products/6811047-202307-carousel-1-2.webp?fm=jpg&auto=format&w=1200&h=1443&fit=crop")!  // Sample image URL
            ),
            Product(
                name: "La Roche-Posay Effaclar Mat",
                productDescription: "This mattifying moisturizer targets excess oil and minimizes pores, making it ideal for oily skin.",
                suitableSkinType: [.oily],
                purchaseLink: URL(string: "https://www.amazon.ca/s?k=la+roche+posay+effaclar+mat&tag=googcana-20&ref=pd_sl_2wiarkgc1x_e")!,
                imageURL: URL(string: "https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/effaclar/effaclar-mat/la-roche-posay-face-care-effaclar-mat-sebo-controlling-moisturizer-40ml-3337872413025-front.png?cx=0&cy=0&cw=600&ch=600&hash=612AFB1A4AFB200B1AF55725A5BCF358")!  // Sample image URL
            ),
            Product(
                name: "Clinique Dramatically Different Moisturizing Gel",
                productDescription: "This oil-free gel provides hydration without adding shine, perfect for combination skin types.",
                suitableSkinType: [.combination],
                purchaseLink: URL(string: "https://www.clinique.ca/product/1687/5047/skincare/moisturizers/dramatically-differenttm-moisturizing-gel")!,
                imageURL: URL(string: "https://m.clinique.com.my/media/export/cms/products/1200x1500/cl_sku_6EM601_1200x1500_0.png")!  // Sample image URL
            ),
            Product(
                name: "Cetaphil Daily Hydrating Lotion",
                productDescription: "Gentle and non-irritating, this hydrating lotion is ideal for normal skin.",
                suitableSkinType: [.normal],
                purchaseLink: URL(string: "https://www.amazon.ca/s?k=cetaphil+daily+hydrating+lotion&tag=googcana-20&ref=pd_sl_26gj0ouzz9_e")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/61-RlJ0iNfL._SL1500_.jpg")!  // Sample image URL
            ),
            Product(
                name: "Neutrogena Oil-Free Acne Moisturizer",
                productDescription: "This moisturizer contains salicylic acid to help clear breakouts and prevent new ones, while keeping skin hydrated. Suitable for oily skin.",
                suitableSkinType: [.oily],
                purchaseLink: URL(string: "https://www.neutrogena.ca/face/moisturizer/neutrogena-oil-free-acne-moisturizer-pink-grapefruit")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/71mdvro-n5L._SL1500_.jpg")!  // Sample image URL
            )
        ]
        
        for product in sampleProducts {
                context.insert(product)
            }
            do {
                try context.save() // Ensure changes are saved
                print("Products added and context saved successfully")
            } catch {
                print("Failed to save context: \(error)")
            }
    }
}
