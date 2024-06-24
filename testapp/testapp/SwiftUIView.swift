//
//  SwiftUIView.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI
import PhotosUI

struct SwiftUIView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State var image: UIImage?
   
    var body: some View {
    
        VStack {
            PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem) {
                    Task {
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                        }
                        print("Failed to load the image")
                    }
                }
            
            if let image {
             Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
    }
}

#Preview {
    SwiftUIView()
}


