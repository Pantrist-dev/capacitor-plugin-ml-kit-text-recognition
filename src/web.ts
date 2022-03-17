import { WebPlugin } from '@capacitor/core';

import type { CapacitorPluginMlKitTextRecognitionPlugin } from './definitions';

export class CapacitorPluginMlKitTextRecognitionWeb extends WebPlugin implements CapacitorPluginMlKitTextRecognitionPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
