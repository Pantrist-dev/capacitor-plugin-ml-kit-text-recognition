# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [5.0.0](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/compare/v4.1.1...v5.0.0) (2023-05-03)


### ⚠ BREAKING CHANGES

* **cap-5:** support capacitor 5

### Features

* **cap-5:** support capacitor 5 ([bd4b403](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/bd4b4039688896bd39d9dd87cf18637cee15d87b))

### [4.1.1](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/compare/v4.1.0...v4.1.1) (2023-03-22)


### Bug Fixes

* **ios:** set explicit ml-kit version in podspec file [#8](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/issues/8) ([dda78e9](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/dda78e9d6c6d4a8c3697cc2b7d9b45fd8c6555ea))

## [4.1.0](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/compare/v4.0.1...v4.1.0) (2022-12-20)


### Features

* add rotation attribute to DetectImageOptions ([73a09c1](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/73a09c1cb89ca45aa7b014ec0cf6e477aa846842))
* **android:** make version of com.google.android.gms:play-services-mlkit-text-recognition configurable ([c1936de](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/c1936de5c4efeaae96bccfcc7daeca0ed0487977))
* **android:** update mlkitTextRecognitionVersion to 18.0.2 ([94ebf35](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/94ebf35ab3aa6887d3c4563e4ef0ae83bda17cc7))
* **ios:** upgrade MLKit to version 3.2.0 ([b047421](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/b047421131c5ef7b4de828c7cd2c840a1b02c7a9))


### Bug Fixes

* **ios:** resolve small warning for ios ([02daf9c](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/02daf9c412481690ec6023481ffa53088ee1fa48))

## 4.0.1 (2022-09-09)

### Bug Fixes

* **null-pointer:** solves issue with null-pointer exception for empty image ([a8cc0a5](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/a8cc0a595c124592dbdb6bfca813e658999b37f9))

## 4.0.0 (2022-06-08)

### ⚠ BREAKING CHANGES

* **cap4-migration:** migrate to cap 4
* **greater-interface:** resolve whole result of ml-kit

### Features

* **cap4-migration:** migrate to cap 4 ([6662e03](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/6662e032111298f858005b67b0d207a9800228ff))


## 2.0.0 (2020-07-27)

### FEATURES

* **greater-interface:** resolve whole result of ml-kit ([34e20cb](https://github.com/Pantrist-dev/capacitor-plugin-ml-kit-text-recognition/commit/34e20cb1c6b68a4dd8d5ce27ab9fcf0ebc6d3a59))

### BREAKING CHANGES

- To get the previous `lines` array you now have to use `blocks.map(block => block.text)`


## 1.0.0 (2022-05-19)

- Initial release