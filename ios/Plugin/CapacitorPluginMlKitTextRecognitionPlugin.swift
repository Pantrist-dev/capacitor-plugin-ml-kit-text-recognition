import Foundation
import Capacitor
import Vision
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorPluginMlKitTextRecognitionPlugin)
public class CapacitorPluginMlKitTextRecognitionPlugin: CAPPlugin {
    private let implementation = CapacitorPluginMlKitTextRecognition()
    
    @objc func detectText(_ call: CAPPluginCall) {
        guard let encodedImage = call.getString("base64Image") else {
            call.reject("No image is given!")
            return
        }
        let rotation = call.getInt("rotation") ?? 0
        
        let orientation = visionImageOrientation(rotation: rotation)
        
        let languages:[String] = ["eng"]

        let dataDecoded : Data = Data(base64Encoded: encodedImage, options: .ignoreUnknownCharacters)!
        guard let image = UIImage(data: dataDecoded) else {
            call.reject("Unable to parse image")
            return
        }
        
        guard let cgImage = image.cgImage else {
          call.reject("Image was not properly converted!")
          return
        }
        
        implementation.recognize(call: call, languages: languages, cgImage: cgImage, orientation: orientation)
    }

    public func visionImageOrientation(rotation: Int) -> CGImagePropertyOrientation {
        switch rotation {
        case 0:
            return CGImagePropertyOrientation.up
        case 90:
            return CGImagePropertyOrientation.left
        case 180:
            return CGImagePropertyOrientation.down
        case 270:
            return CGImagePropertyOrientation.right
        default:
            return CGImagePropertyOrientation.up
        }
    }
}
