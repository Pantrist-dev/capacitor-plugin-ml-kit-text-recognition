export interface CapacitorPluginMlKitTextRecognitionPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
