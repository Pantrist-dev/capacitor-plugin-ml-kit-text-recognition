# @pantrist/capacitor-plugin-ml-kit-text-recognition

Capacitor Wrapper for TextRecognition of Gogoles ML-Kit

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


## API

<docgen-index></docgen-index>

<docgen-api>
<!-- run docgen to generate docs from the source -->
<!-- More info: https://github.com/ionic-team/capacitor-docgen -->
</docgen-api>
