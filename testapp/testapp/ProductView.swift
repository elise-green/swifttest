import SwiftUI
import SwiftData

struct ProductView: View {
    // Fetching products from the database
    @Query private var products: [Product]
    
    // State to manage the selected tab
    @State private var selectedTab: Tabs = .products

    var body: some View {
        VStack {
            if products.isEmpty {
                Text("No products available")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                ScrollView {
                    VStack {
                        ForEach(products) { product in
                            VStack {
                                // Display product image
                                AsyncImage(url: product.imageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 250, height: 300)
                                .cornerRadius(20)

                                // Display product details
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.headline)
                                        .foregroundColor(Color("AccentColor"))

                                    Text(product.productDescription)
                                        .font(.body)
                                        .padding(.vertical, 5)

                                    Link("Buy Now", destination: product.purchaseLink)
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color.white)  // Background color for product details
                                .cornerRadius(10)
                                .shadow(radius: 5)  // Adding shadow for better appearance
                                .padding([.leading, .trailing])
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
                .background(
                    Image("BackgroundImage")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
                .navigationTitle("Products")
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    ProductView()
}
