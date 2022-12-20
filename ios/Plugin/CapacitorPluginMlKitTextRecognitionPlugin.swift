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
        guard let encodedImage = call.getString("base64Image") else {
            call.reject("No image is given!")
            return
        }
        let rotation = call.getInt("rotation") ?? 0

        let dataDecoded : Data = Data(base64Encoded: encodedImage, options: .ignoreUnknownCharacters)!
        guard let image = UIImage(data: dataDecoded) else {
            call.reject("Unable to parse image")
            return
        }

        let latinOptions = TextRecognizerOptions()
        let textRecognizer = TextRecognizer.textRecognizer(options: latinOptions)
        let visionImage = VisionImage(image: image)
        visionImage.orientation = visionImageOrientation(rotation: rotation)

        textRecognizer.process(visionImage) { result, error in
          guard error == nil, let result = result else {
            // Error handling
            call.reject("Error on processing image")
            return
          }

          let textBlocks = NSMutableArray()
          for textBlock: TextBlock in result.blocks {
            let lines = NSMutableArray()
            for line: TextLine in textBlock.lines {
              let elements = NSMutableArray()
              for element: TextElement in line.elements {
                elements.add([
                  "text": element.text,
                  "boundingBox": [
                    "left": element.frame.minX,
                    "top": element.frame.maxY,
                    "right": element.frame.maxX,
                    "bottom": element.frame.minY,
                  ],
                  "recognizedLanguage": element.recognizedLanguages.first?.languageCode ?? ""
                ])
              }

              lines.add([
                "text": line.text,
                "boundingBox": [
                    "left": line.frame.minX,
                    "top": line.frame.maxY,
                    "right": line.frame.maxX,
                    "bottom": line.frame.minY,
                ],
                "recognizedLanguage": line.recognizedLanguages.first?.languageCode ?? "",
                "elements": elements
              ])
            }

            textBlocks.add([
               "text": textBlock.text,
               "boundingBox": [
                 "left": textBlock.frame.minX,
                 "top": textBlock.frame.maxY,
                 "right": textBlock.frame.maxX,
                 "bottom": textBlock.frame.minY,
               ],
               "recognizedLanguage": textBlock.recognizedLanguages.first?.languageCode ?? "",
               "lines": lines
             ])
          }

          call.resolve([
            "text": result.text,
            "blocks": textBlocks
          ])
        }
    }

    public func visionImageOrientation(rotation: Int) -> UIImage.Orientation {
        switch rotation {
        case 0:
            return .up
        case 90:
            return .left
        case 180:
            return .down
        case 270:
            return .right
        default:
            return .up
        }
    }
}
