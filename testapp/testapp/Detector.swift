//
//  Detector.swift
//  testapp
//
//  Created by Elise Green on 2024-08-29.
//

import Foundation
import UIKit
import Vision


struct Detector{
    var box: CGRect
    var label: String
}


class ObjectDetector{
    var standardSize: CGSize{
        CGSize(width: 640, height: 640)
    }
    
    
    init() {
        loadModel()
    }
    
    func recognize(fromImage image:UIImage, completion:@escaping([Detector])-> Void ) {
        guard let cgImage = image.cgImage else{
            completion([])
            return
        }
        self.completion = completion
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        }
        catch{
            print(error)
        }
        
    }
    
    func recognize( fromPixelBuffer pixelBuffer: CVImageBuffer, completion:@escaping([Detector]) ->Void ){
        self.completion = completion
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                        options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        }
        catch {
            print(error)
        }
    }
    
    private func loadModel() {
        do {
            // Use the pre-integrated CoreML model called acneDetector
            let visionModel = try VNCoreMLModel(for: acnedetector().model)
            
            // Create the VNCoreMLRequest with the visionModel
            let objectRecognition = VNCoreMLRequest(model: visionModel) { (request, error) in
                if let results = request.results {
                    self.processResults(results)
                } else {
                    print("No results error: \(String(describing: error?.localizedDescription))")
                }
            }
            
            // Set the image crop and scale option
            objectRecognition.imageCropAndScaleOption = .scaleFit
            
            // Assign the request to the requests array
            self.requests = [objectRecognition]
            
        } catch let error as NSError {
            print("Error while loading model: \(error)")
        }
    }

    private func processResults(_ results:[Any]){
        var detectors:[Detector] = []
        for result in results {
            guard let vnResult = result as? VNRecognizedObjectObservation,
                  let label = vnResult.labels.first else {
                continue
            }
            print("detected \(label.identifier) confidence \(label.confidence)")
                       if label.confidence > confidenceThreshold {
                           detectors.append(Detector(box: vnResult.boundingBox, label: label.identifier))
                       }
                   }
                   completion?(detectors)
               }
    
    private var completion:(([Detector]) -> Void)?
    private let confidenceThreshold:Float = 0.1
    private var requests:[VNRequest] = []

               
        }



