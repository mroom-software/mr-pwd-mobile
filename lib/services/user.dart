import 'dart:convert';

import 'package:blockpass/config/app.dart';
import 'package:blockpass/data/models/pwd.dart';
import 'package:blockpass/utils/security.dart';
import 'package:blockpass/utils/utils.dart';

class UserSrv {

  Future<List<Pwd>> getListPwds() async {
    List<Pwd> entries = [];  
    var security = Security();
    String k = await utils.getSecureData('priKey');
    security.priKey = k.substring(0, 32);

    if (app.user.data != null && app.user.data.isNotEmpty) {
      final String decryptedStr = security.decryptString(app.user.data);
      List<dynamic> lst = json.decode(decryptedStr); 
      for (int i = 0; i < lst.length; i++) {
        Pwd pwd = Pwd.fromJson(jsonDecode(lst[i]));
        entries.add(pwd);
      }
    }
    
    return entries;
  }

  Future<void> saveData(List<Pwd> pwds) async {
    if (pwds.length == 0) {
      app.user.data = '';
    } else {
      var security = Security();
      String k = await utils.getSecureData('priKey');
      security.priKey = k.substring(0, 32);
      String tmp = security.encryptString(jsonEncode(pwds));
      app.user.data = tmp;
    }
  }

  void syncJob() {

  }

  void syncNow() {

  } 
}

final userSrv = UserSrv();