import Foundation
import Capacitor
import Vision

@objc public class CapacitorPluginMlKitTextRecognition: NSObject {
    
    var recognizedText: [String: Any] = [
        "text": "",
        "blocks": []
    ]
    var imageWidth: Double = 0
    var imageHeight: Double = 0
    
    @objc public func recognize(call: CAPPluginCall, languages: Array<String>, cgImage: CGImage, orientation: CGImagePropertyOrientation) {
        // caching image size to convert the bboxes later
        self.imageWidth = Double(cgImage.width)
        self.imageHeight = Double(cgImage.height)
        
        // create the request
        let request = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
        request.recognitionLevel = .accurate
        request.recognitionLanguages = languages
        
        // create the rerquest handler
        let imageRequestHandler = VNImageRequestHandler(
            cgImage: cgImage,
            orientation: orientation,
            options: [:]
        )
        
        // add to the global queue
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform([request])
                call.resolve(self.recognizedText)
            } catch let error as NSError {
                print("Failed to perform image request: \(error)")
                call.reject(error.description)
            }
        }
    }
    
    ///  Transforms the VNRequest to the JS Array with the recognized text
    ///
    ///  - Parameters:
    ///    - request: pointer to the request to the Vision framework, to get the results
    ///    - error: error message if something is wrong
    ///
    ///  - Returns:
    func handleDetectedText(request: VNRequest?, error: Error?) {
        if let error = error {
            NSLog("Error detecting text: \(error)")
            return
        }
        
        guard let observations = request?.results as? [VNRecognizedTextObservation], observations.count > 0 else {
            NSLog("No text found")
            return
        }
        
        var fullText = ""
        
        let textBlocks: [[String: Any]] = observations.compactMap { observation in


            // Find the top observation.
            guard let candidate = observation.topCandidates(1).first else { return nil }
            
            fullText = candidate.string
            let confidence = candidate.confidence
            
            
            let words = fullText.components(separatedBy: " ")
            
            let elements: [[String: Any]] = words.compactMap { word in
                let stringRange = word.startIndex..<word.endIndex
                   let wordBoxObservation = try? candidate.boundingBox(for: stringRange)
                    // Get the normalized CGRect value.
                    let boundingBox = wordBoxObservation?.boundingBox ?? .zero
                    
                    // Convert the rectangle from normalized coordinates to image coordinates.
                    let normalizedBox = VNImageRectForNormalizedRect(boundingBox,
                                                        Int(self.imageWidth),
                                                        Int(self.imageHeight))
                    return [
                        "text": word,
                        "confidence": confidence,
                        "boundingBox": [
                            "left": normalizedBox.minX,
                            "top": normalizedBox.maxY,
                            "right": normalizedBox.maxX,
                            "bottom": normalizedBox.minY,
                        ],
                        "recognizedLanguage": "eng"
                    ]
                    
            }
            
            let lines = NSMutableArray()
            lines.add([
                "elements": elements
            ] as [String : Any])
            
            return [
                "lines": lines
            ]
        }
        
        self.recognizedText = [
            "text": fullText,
            "blocks": textBlocks
        ]
        
    }
    
    /// Convert Vision coordinates to pixel coordinates within image.
    ///
    /// - Parameters:
    ///   - boundingBox: The bounding box returned by Vision framework.
    ///   - width: Image width in pixels.
    ///   - height: Image height in pixels.
    ///
    /// - Returns: The bounding box in pixel coordinates within the initial image.
    
    func convertBbox(boundingBox: CGRect, width imageWidth: Double, height imageHeight: Double) -> [String : CGFloat] {
        // Begin with input rect.
        var rect = boundingBox
        
        // Reposition origin.
        rect.origin.x *= imageWidth
        rect.origin.y = (1 - rect.maxY) * imageHeight
        
        // Rescale normalized coordinates.
        rect.size.width *= imageWidth
        rect.size.height *= imageHeight
        
        let bbox = [
            "x0": rect.origin.x,
            "y0": rect.origin.y,
            "x1": rect.origin.x + rect.size.width,
            "y1": rect.origin.y + rect.size.height
        ]
        return bbox
    }
}
