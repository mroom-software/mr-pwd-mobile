
import 'package:blockpass/data/models/user.dart';

class AppConfig {
  
  static final AppConfig _appConfig = new AppConfig._internal();
  
  String baseURL = 'http://localhost:8000/api';
  List<String> eosNetworks = ['Mainnet', 'Kylin Testnet', 'Jungle Testnet'];
  Map<String, String> eosNetworkURL = {
    'Mainnet': 'https://api.eosnewyork.io',
    'Kylin Testnet': 'http://kylin.fn.eosbixin.com',
    'Jungle Testnet': 'http://85.214.253.244:8888',
  };

  User user;

  factory AppConfig() {
    return _appConfig;
  }

  AppConfig._internal();
}

final app = AppConfig();