//
//  RetakeView.swift
//  testapp
//
//  Created by Isobel Adams on 2024-08-22.
//

import SwiftUI
import CoreML
import Vision

struct RetakeView: View {
    @State var image: UIImage?
    @State private var isCameraViewPresented = false
    @State public var confirmedImage: UIImage?
    @State private var showResults = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } else {
                    Color.gray.ignoresSafeArea()
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
                            if let image = image {
                                confirmedImage = processImageWithBoundingBoxes(image)
                                self.showResults = true
                            }
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
            .navigationDestination(isPresented: $showResults) {
                ResultsView(processedImage: confirmedImage ?? UIImage())
            }
        }

    }
    
    // Function to handle CoreML processing and drawing bounding boxes
    func processImageWithBoundingBoxes(_ image: UIImage) -> UIImage? {
        guard let model = try? VNCoreMLModel(for: acnedetector().model) else {
            print("Failed to load CoreML model")
            return nil
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let results = request.results as? [VNRecognizedObjectObservation] {
                confirmedImage = drawBoundingBoxes(on: image, with: results)
            }
        }
        
        if let cgImage = image.cgImage {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
        
        return confirmedImage
    }
    
    // Function to draw bounding boxes on the image
    func drawBoundingBoxes(on image: UIImage, with observations: [VNRecognizedObjectObservation]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw the original image
        image.draw(at: .zero)
        
        // Set the bounding box color and line width
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(2.0)
        
        // Draw each bounding box
        for observation in observations {
            let boundingBox = observation.boundingBox
            let size = image.size
            let rect = CGRect(
                x: boundingBox.origin.x * size.width,
                y: (1 - boundingBox.origin.y - boundingBox.height) * size.height,
                width: boundingBox.width * size.width,
                height: boundingBox.height * size.height
            )
            context.stroke(rect)
        }
        
        // Get the new image with bounding boxes
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
}

struct RetakeView_Previews: PreviewProvider {
    static var previews: some View {
        RetakeView()
    }
}
