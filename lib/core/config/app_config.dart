/// Application configuration constants
enum Environment { dev, prod }

class AppConfig {
  final Environment environment;
  final String appName;
  final String baseUrl;
  final bool enableAnalytics;

  const AppConfig._internal({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableAnalytics,
  });

  static const AppConfig dev = AppConfig._internal(
    environment: Environment.dev,
    appName: 'Task App',
    baseUrl: 'https://dev.api.example.com',
    enableAnalytics: false,
  );

  static const AppConfig prod = AppConfig._internal(
    environment: Environment.prod,
    appName: 'Task App',
    baseUrl: 'https://api.example.com',
    enableAnalytics: true,
  );

  // Default config used in the app, can be switched in main.dart
  static const AppConfig current = dev;
}
