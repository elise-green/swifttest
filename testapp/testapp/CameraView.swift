//
//  SwiftUIView.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI
import PhotosUI
import CoreData


struct CameraView: View {
    
    @State public var image: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    @State private var isRetakeViewPresented = false
    @State private var selectedItem: PhotosPickerItem?
    
    
    
    
    var body: some View {
        ZStack {
            
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .trailing) {
                
                Spacer()
                
        
                
                HStack(alignment: .top) {
                    
                    Button(action: { isCustomCameraViewPresented.toggle()
                        
                    }, label: {
                        Image(systemName: "camera.fill")
                            .frame(width: 100)
                            .font(.largeTitle)
                            .padding()
                            .background(.accent)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        
                        
                        
                        
                    })
                    .padding(.bottom)
                    .sheet(isPresented: $isCustomCameraViewPresented, content: {
                        CustomCameraView(capturedImage: $image)
                    })
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Image(systemName: "photo.artframe")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accent)
                                .clipShape(Circle())
                        }
                        .onChange(of: selectedItem, initial: false) { oldValue, newValue in
                            if let newValue {
                                Task {
                                    if let data = try? await newValue.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        image = uiImage
                                        isRetakeViewPresented.toggle()
                                    }
                                }
                            }
                        }
                    
                    
                    
                    
                }
                
                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)
            .sheet(isPresented: $isRetakeViewPresented) {
                RetakeView(image: image)
            }
            
        }
    }
}




struct ContentViewfr_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
