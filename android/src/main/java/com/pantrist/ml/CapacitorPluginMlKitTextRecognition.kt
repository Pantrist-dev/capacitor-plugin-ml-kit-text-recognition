package com.pantrist.ml

import android.util.Base64
import com.getcapacitor.*
import com.getcapacitor.annotation.CapacitorPlugin
import java.io.IOException
import android.graphics.BitmapFactory
import android.graphics.Rect

import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions

@CapacitorPlugin
class CapacitorPluginMlKitTextRecognition : Plugin() {
    @PluginMethod
    fun detectText(call: PluginCall) {
        val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)

        val encodedImage = call.getString("base64Image")
        if (encodedImage == null) {
            call.reject("No image is given!")
            return
        }
        val rotation = call.getInt("rotation") ?: 0

        val image: InputImage
        try {
            val decodedString: ByteArray = Base64.decode(encodedImage, Base64.DEFAULT);
            val decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size)
            if (decodedByte == null) {
                call.reject("Decoded image is null")
                return
            }
            image = InputImage.fromBitmap(decodedByte, rotation)
        } catch (e: IOException) {
            call.reject("Unable to parse image")
            return
        }

        recognizer.process(image)
            .addOnSuccessListener { visionText ->
                val ret = JSObject()
                ret.put("text", visionText.text)

                val textBlocks = JSArray()
                visionText.textBlocks.forEach { block ->
                    val blockObject = JSObject();
                    blockObject.put("text", block.text)
                    blockObject.put("boundingBox", parseRectToJsObject(block.boundingBox))
                    blockObject.put("recognizedLanguage", block.recognizedLanguage)

                    val linesArray = JSArray()
                    block.lines.forEach { line ->
                        val lineObject = JSObject()
                        lineObject.put("text", line.text)
                        lineObject.put("boundingBox", parseRectToJsObject(line.boundingBox))
                        lineObject.put("recognizedLanguage", line.recognizedLanguage)

                        val elementArray = JSArray()
                        line.elements.forEach { element ->
                            val elementObject = JSObject()
                            elementObject.put("text", element.text)
                            elementObject.put("confidence", element.confidence)
                            elementObject.put("boundingBox", parseRectToJsObject(element.boundingBox))
                            elementObject.put("recognizedLanguage", line.recognizedLanguage)
                            elementArray.put(elementObject)
                        }
                        lineObject.put("elements", elementArray)
                        linesArray.put(lineObject)
                    }
                    blockObject.put("lines", linesArray)
                    textBlocks.put(blockObject)
                };
                ret.put("blocks", textBlocks)

                call.resolve(ret)
            }
            .addOnFailureListener { e ->
                call.reject("Unable process image!", e)
            }
    }

    private fun parseRectToJsObject(rect: Rect?): JSObject? {
        if (rect == null) {
            return null
        }

        val returnObject = JSObject();
        returnObject.put("left", rect.left)
        returnObject.put("top", rect.top)
        returnObject.put("right", rect.right)
        returnObject.put("bottom", rect.bottom)
        return returnObject;
    }
}