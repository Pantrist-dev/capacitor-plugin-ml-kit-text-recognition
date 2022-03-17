import { registerPlugin } from '@capacitor/core';

import type { CapacitorPluginMlKitTextRecognitionPlugin } from './definitions';

const CapacitorPluginMlKitTextRecognition = registerPlugin<CapacitorPluginMlKitTextRecognitionPlugin>('CapacitorPluginMlKitTextRecognition', {
  web: () => import('./web').then(m => new m.CapacitorPluginMlKitTextRecognitionWeb()),
});

export * from './definitions';
export { CapacitorPluginMlKitTextRecognition };
