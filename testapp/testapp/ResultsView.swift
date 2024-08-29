//
//  ResultsView.swift
//  testapp
//
//  Created by Elise Green on 2024-08-29.
//

import SwiftUI

struct ResultsView: View {
    let processedImage: UIImage
    let pimpleCount: Int
    @State private var detectors: [Detector] = []
    private let detector = ObjectDetector()
    
    var body: some View {
        VStack {
            Text("Number of Pimples: \(pimpleCount)")
                .font(.title)
                .padding()
            
            Image(uiImage: processedImage)
                .resizable()
                .scaledToFit()
                .frame(width: 262.5, height: 350)
                .background(Color.gray)
                .cornerRadius(10)
                .padding()
            
            if detectors.isEmpty {
                Text("Detecting pimples...")
                    .padding()
            } else {
                Text("Detected \(detectors.count) pimples")
                    .padding()
                
                // Display detection results (optional)
                ForEach(detectors, id: \.label) { detector in
                    Text("\(detector.label) at \(detector.box)")
                        .padding()
                }
            }
        }
        .navigationTitle("Results")
        .onAppear {
            performDetection()
        }
    }
    
    private func performDetection() {
        detector.recognize(fromImage: processedImage) { detectedObjects in
            DispatchQueue.main.async {
                self.detectors = detectedObjects
            }
        }
    }
}
