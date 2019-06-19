
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

  void userInfo(Function(String) callback) async {
    try {
      if (_eosClient.keys.keys.length > 0) {
        String pubKey = _eosClient.keys.keys.first;
        AccountNames accountNames = await _eosClient.getKeyAccounts(pubKey);
        if (accountNames.accountNames.length > 0) {
          print('WTF 1');
          callback(accountNames.accountNames.first);
        } else {
          callback('');
        }
      }
    } catch (e) {
      print(e);
      callback('');
    } 
  }

  void myPwds(String contract, String actor, {Function callback}) async {
    List<Map<String, dynamic>> data = await _eosClient.getTableRows(contract, actor, 'note');
    if (callback != null) {
      callback(data);
    }
    // _eosClient.getTableRows(contract, actor, 'note').then((data) => {
    //   print('data = ${data}')
    //   // data.forEach((item) {
    //   //   print(item);
    //   // })
    // });
  }

  void add(String contract, String actor, String pwds, int syncTime) {
    List<Authorization> auth = [
      Authorization()
        ..actor = actor
        ..permission = 'active'
    ];

    Map data = {
      'owner': actor,
      'data': pwds,
      'timestamp': syncTime,
    };

    List<Action> actions = [
      Action()
        ..account = contract
        ..name = 'add'
        ..authorization = auth
        ..data = data
    ];

    Transaction transaction = Transaction()..actions = actions;
    _eosClient.pushTransaction(transaction, broadcast: true).then((trx) {
      print(trx);
    });
  }
}

final eos = new EOS();