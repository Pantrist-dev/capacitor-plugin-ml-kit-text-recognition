# @pantrist/capacitor-plugin-ml-kit-text-recognition

[![npm version](https://badge.fury.io/js/@pantrist%2Fcapacitor-plugin-ml-kit-text-recognition.svg)](https://badge.fury.io/js/@pantrist%2Fcapacitor-plugin-ml-kit-text-recognition)
![npm downloads per month](https://img.shields.io/npm/dm/@pantrist/capacitor-plugin-ml-kit-text-recognition)

Capacitor Wrapper for TextRecognition of Googles ML-Kit

## Install

```bash
npm install @pantrist/capacitor-plugin-ml-kit-text-recognition
npx cap sync
```

## Configuration

### Android

**Optional** but recommended:
You can configure your app to automatically download the ML model to the device after your app is installed from the Play Store.
To do so, add the following declaration to your app's ``AndroidManifest.xml`` file:

```xml
<application ...>
  ...
  <meta-data
      android:name="com.google.mlkit.vision.DEPENDENCIES"
      android:value="ocr" />
  <!-- To use multiple models: android:value="ocr,model2,model3" -->
</application>
```

### iOS

Nothing to do for iOS


## Supported methods

| Name      | Android | iOS | Web |
| ----------- | ----------- |-----|-----|
| detectText   | ✅        | ✅    | ❌    |

## API

<docgen-index>

* [`detectText(...)`](#detecttext)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### detectText(...)

```typescript
detectText(options: DetectImageOptions) => Promise<TextDetectionResult>
```

Tries to detect text from the given image

| Param         | Type                                                              | Description                    |
| ------------- | ----------------------------------------------------------------- | ------------------------------ |
| **`options`** | <code><a href="#detectimageoptions">DetectImageOptions</a></code> | Options for the text detection |

**Returns:** <code>Promise&lt;<a href="#textdetectionresult">TextDetectionResult</a>&gt;</code>

--------------------


### Interfaces


#### TextDetectionResult

| Prop         | Type                 | Description          |
| ------------ | -------------------- | -------------------- |
| **`text`**   | <code>string</code>  | Found text           |
| **`blocks`** | <code>Block[]</code> | Parsed text by lines |


#### Block

| Prop        | Type                |
| ----------- | ------------------- |
| **`lines`** | <code>Line[]</code> |


#### Line

| Prop           | Type                   |
| -------------- | ---------------------- |
| **`elements`** | <code>Element[]</code> |


#### Element


#### DetectImageOptions

| Prop              | Type                | Description                                                                                      |
| ----------------- | ------------------- | ------------------------------------------------------------------------------------------------ |
| **`base64Image`** | <code>string</code> | The image to detect texts from                                                                   |
| **`rotation`**    | <code>number</code> | The image's counter-clockwise orientation degrees. Only 0, 90, 180, 270 are supported. Default 0 |

</docgen-api>
