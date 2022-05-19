import Foundation
import Capacitor
import MLKitVision
import MLKitTextRecognition
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorPluginMlKitTextRecognitionPlugin)
public class CapacitorPluginMlKitTextRecognitionPlugin: CAPPlugin {
    @objc func detectText(_ call: CAPPluginCall) {
        guard var encodedImage = call.getString("base64Image") else {
            call.reject("No image is given!")
            return
        }

        let dataDecoded : Data = Data(base64Encoded: encodedImage, options: .ignoreUnknownCharacters)!
        guard let image = UIImage(data: dataDecoded) else {
            call.reject("Unable to parse image")
            return
        }

        let latinOptions = TextRecognizerOptions()
        let textRecognizer = TextRecognizer.textRecognizer(options: latinOptions)
        let visionImage = VisionImage(image: image)
        
        textRecognizer.process(visionImage) { result, error in
          guard error == nil, let result = result else {
            // Error handling
            call.reject("Error on processing image")
            return
          }
            
          let linesArray = NSMutableArray()
          
          for textBlock: TextBlock in result.blocks {
            linesArray.add(textBlock.text)
          }
            
          call.resolve([
            "text": result.text,
            "lines": linesArray
          ])
        }
    }
}
