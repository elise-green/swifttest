//
//  CustomCameraView.swift
//  testapp
//
//  Created by Isobel Adams on 2024-08-22.
//

import Foundation
import SwiftUI

struct CustomCameraView: View {
    @State private var isRetakeViewPresented = false
    
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    
    var body: some View {
        ZStack {
            CameraServiceView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                        isRetakeViewPresented = true  // Show RetakeView when photo is captured
                    } else {
                        print("Error: no image data found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    cameraService.capturePhoto()
                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                })
                .padding(.bottom)
            }
            .sheet(isPresented: $isRetakeViewPresented) {
                RetakeView(image: capturedImage)  // Present RetakeView as a sheet
            }
        }
    }
}




