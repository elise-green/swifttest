//
//  RetakeView.swift
//  testapp
//
//  Created by Isobel Adams on 2024-08-22.
//

import Foundation
import SwiftUI

struct RetakeView: View {
    @State var image: UIImage?
    @State private var isCameraViewPresented = false
    @State public var confirmedImage: UIImage?
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Color.gray.ignoresSafeArea() // should always be a image when retake view is presnted
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Button("Retake") {
                     isCameraViewPresented.toggle()
                    }
                    .font(.title)
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.bottom)
                    
                    
                    Button("Use") {
                        confirmedImage = image
                    }
                    .font(.title)
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.bottom)
                    
                }
                
            }
                
        }
        .sheet(isPresented: $isCameraViewPresented) {
           CameraView()
        }
    }
}

struct RetakeView_Previews: PreviewProvider {
    static var previews: some View {
        RetakeView()
    }
}





