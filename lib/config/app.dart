
class AppConfig {
  

  static final AppConfig _appConfig = new AppConfig._internal();
  
  String baseURL = 'http://localhost:8000/api';

  factory AppConfig() {
    return _appConfig;
  }

  AppConfig._internal();
}

final app = AppConfig();