export interface CapacitorPluginMlKitTextRecognitionPlugin {
  /**
   * Tries to detect text from the given image
   * @param options Options for the text detection
   * @returns Resolved texts
   */
  detectText(options: DetectImageOptions): Promise<TextDetectionResult>;
}

export interface DetectImageOptions {
  /**
   * The image to detect texts from
   */
  base64Image: string;
}

export interface TextDetectionResult {
  /**
   * Found text
   */
  text: string;
  /**
   * Parsed text by lines
   */
  lines: string[]
}
