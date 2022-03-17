import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorPluginMlKitTextRecognitionPlugin)
public class CapacitorPluginMlKitTextRecognitionPlugin: CAPPlugin {
    @objc func detectText(_ call: CAPPluginCall) {
        guard var filename = call.getString("filename") else {
            call.reject("No filename is given!")
            return
        }

        // removeFirst(7) removes the initial "file://"
        filename.removeFirst(7)
        guard let image = UIImage(contentsOfFile: filename) else {
            call.reject("Unable to find image at", uri)
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
