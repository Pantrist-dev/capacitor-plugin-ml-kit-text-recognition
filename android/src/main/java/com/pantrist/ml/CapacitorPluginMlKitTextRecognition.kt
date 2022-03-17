package com.pantrist.ml

import android.net.Uri
import com.getcapacitor.*
import com.getcapacitor.annotation.CapacitorPlugin
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import java.io.IOException

@CapacitorPlugin
class CapacitorPluginMlKitTextRecognition : Plugin() {
    @PluginMethod
    fun detectText(call: PluginCall) {
        val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)

        val uri = call.getString("filename")
        if (uri == null) {
            call.reject("No filename is given!")
            return
        }

        val image: InputImage
        try {
            image = InputImage.fromFilePath(context, Uri.parse(uri))
        } catch (e: IOException) {
            call.reject("Unable to find image at", uri)
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