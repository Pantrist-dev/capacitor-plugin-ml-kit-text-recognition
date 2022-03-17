import { WebPlugin } from '@capacitor/core';

import type { CapacitorPluginMlKitTextRecognitionPlugin, DetectImageOptions, TextDetectionResult } from './definitions';

export class CapacitorPluginMlKitTextRecognitionWeb extends WebPlugin implements CapacitorPluginMlKitTextRecognitionPlugin {
  // @ts-ignore
  detectText(options: DetectImageOptions): Promise<TextDetectionResult> {
    return Promise.reject("Web Plugin Not implemented");
  }
}
