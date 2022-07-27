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
  blocks: Block[]
}

export interface Block extends TextBase {
  lines: Line[];
}

export interface Line extends TextBase {
  elements: Element[];
}

export interface Element extends TextBase {}

export interface TextBase {
  text: string;
  boundingBox: BoundingBox;
  recognizedLanguage: string;
}

export interface BoundingBox {
  left: number;
  top: number;
  right: number;
  bottom: number;
}