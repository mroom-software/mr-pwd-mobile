
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

  void userInfo(Function(String) callback) {
    try {
      if (_eosClient.keys.keys.length > 0) {
        String pubKey = _eosClient.keys.keys.first;
        _eosClient.getKeyAccounts(pubKey).then((AccountNames accountNames) {
          if (accountNames.accountNames.length > 0) {
            callback(accountNames.accountNames.first);
          } 
        });
      }
    } catch (e) {
      print(e);
      callback('');
    } 
  }
}