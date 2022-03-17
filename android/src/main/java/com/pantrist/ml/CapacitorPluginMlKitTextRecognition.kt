package com.pantrist.ml

import android.util.Base64
import com.getcapacitor.*
import com.getcapacitor.annotation.CapacitorPlugin
import java.io.IOException
import android.graphics.BitmapFactory

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

        val image: InputImage
        try {
            val decodedString: ByteArray = Base64.decode(encodedImage, Base64.DEFAULT);
            val decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size)
            image = InputImage.fromBitmap(decodedByte, 0);
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
                    textBlocks.put(block.text)
                };
                ret.put("lines", textBlocks)

                call.resolve(ret)
            }
            .addOnFailureListener { e ->
                call.reject("Unable process image!", e)
            }
    }
}