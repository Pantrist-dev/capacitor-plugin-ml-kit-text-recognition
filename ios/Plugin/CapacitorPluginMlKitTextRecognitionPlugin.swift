import Foundation
import Capacitor

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

        let textRecognizer = TextRecognizer.textRecognizer()


        textRecognizer.process(visionImage) { result, error in
          guard error == nil, let result = result else {
            // Error handling
            return
          }
          // Recognized text
        }
    }
}
