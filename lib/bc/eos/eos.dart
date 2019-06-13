
import 'package:eosdart/eosdart.dart';

class EOS {

  static final EOS _singleton = new EOS._internal();
  EOSClient _eosClient;

  factory EOS() {
    return _singleton;
  }

  EOS._internal();

  bool connect(String url, String privKey) {
    try {
      _eosClient = EOSClient(url, 'v1', privateKeys: [privKey]);
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }
  
}