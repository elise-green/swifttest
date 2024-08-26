//
//  Detector.swift
//  testapp
//
//  Created by Elise Green on 2024-08-23.
//

import SwiftUI
import PhotosUI
import CoreML
import Vision



        
func createImageClassifier() -> VNCoreMLModel {
            let defaultConfig = MLModelConfiguration()
            let imageClassifierWrapper = try? acnedetector(configuration: defaultConfig)
            guard let imageClassifier = imageClassifierWrapper else {
                fatalError("App failed to create an image classifier model instance.")
            }
            guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifier.model) else {
                fatalError("App failed to create a VNCoreMLModel instance.")
            }
            return imageClassifierVisionModel
        }
        
        func detectObjectsInImage(_ image: UIImage) {
            guard let cgImage = image.cgImage else {
                fatalError("Unable to get CGImage from UIImage")
            }
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            let request = VNCoreMLRequest(model: createImageClassifier()) { request, error in
                guard let results = request.results as? [VNRecognizedObjectObservation] else {
                    print("Unexpected result type from VNCoreMLRequest")
                    return
                }
                DispatchQueue.main.async {
                   handleDetectionResults(results, in: cgImage)
                   let processedImage = drawBoundingBoxes(on: image)
                }
            }
            
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Failed to perform detection: \(error)")
                }
            }
        }
        
        func handleDetectionResults(_ results: [VNRecognizedObjectObservation], in originalImage: CGImage) {
            let originalWidth = CGFloat(originalImage.width)
            let originalHeight = CGFloat(originalImage.height)
            
            var boundingBoxes: [DetectedObject] = []
            
            for result in results {
                let boundingBox = result.boundingBox
                let label = result.labels.first?.identifier ?? "Unknown"
                
                // Apply the scaling factors
                let x = boundingBox.minX * originalWidth
                let y = (1 - boundingBox.maxY) * originalHeight
                let width = boundingBox.width * originalWidth
                let height = boundingBox.height * originalHeight
                
                let adjustedBoundingBox = CGRect(x: x, y: y, width: width, height: height)
                let detectedObject = DetectedObject(boundingBox: adjustedBoundingBox, label: label)
                boundingBoxes.append(detectedObject)
            }
            
            let detectedBoundingBoxes =  boundingBoxes
        }
        
        func drawBoundingBoxes(on image: UIImage) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: image.size)
            let img = renderer.image { ctx in
                // Draw the original image as the background
                image.draw(at: .zero)
                
                // Set the stroke color for the bounding boxes
                ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
                ctx.cgContext.setLineWidth(2.0)
                
                for detectedObject in detectedBoundingBoxes {
                    // Draw each bounding box
                    ctx.cgContext.stroke(detectedObject.boundingBox)
                    
                    // Draw the label text
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 12),
                        .foregroundColor: UIColor.white,
                        .backgroundColor: UIColor.black
                    ]
                    let label = detectedObject.label
                    let labelSize = label.size(withAttributes: attributes)
                    let labelOrigin = CGPoint(x: detectedObject.boundingBox.midX - labelSize.width / 2,
                                              y: detectedObject.boundingBox.minY - labelSize.height)
                    
                    label.draw(at: labelOrigin, withAttributes: attributes)
                }
            }
            return img
        }
        
        struct DetectedObject: Identifiable {
            let id = UUID()
            let boundingBox: CGRect
            let label: String
        }
        
 
