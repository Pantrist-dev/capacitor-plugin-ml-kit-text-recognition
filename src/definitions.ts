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
  /**
   * The image's counter-clockwise orientation degrees. Only 0, 90, 180, 270 are supported. Default 0
   */
  rotation?: number;
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