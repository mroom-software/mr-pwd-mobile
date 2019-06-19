
import 'dart:convert';

import 'package:blockpass/config/app.dart';
import 'package:blockpass/data/models/pwd.dart';
import 'package:blockpass/utils/security.dart';
import 'package:blockpass/utils/utils.dart';

class User {
  int id;
  String name;
  String password;
  String chainID;
  String network;
  String data;
  int syncTime;
  int enableSync;
  
  User({this.id, this.name, this.password, this.chainID, this.network, this.data, this.syncTime, this.enableSync = 1});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'chainID': chainID,
      'network': network ?? 'eos',
      'data': data,
      'syncTime': syncTime,
      'enableSync': enableSync,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    password = map['password'] as String;
    chainID = map['chainID'] as String;
    network = map['network'] as String;
    data = map['data'] as String;
    syncTime = map['syncTime'] as int;
    enableSync = map['enableSync'] as int;
  }

  @override
  String toString() {
    return ('${this.id} - ${this.name} - ${this.password} - ${this.chainID} - ${this.network} - ${this.data} - ${this.syncTime} - ${this.enableSync}');
  }

  Future<List<Pwd>> getListPwds() async {
    List<Pwd> entries = [];  
    var security = Security();
    String k = await utils.getSecureData('priKey');
    security.priKey = k.substring(0, 32);

    if (data != null && data.isNotEmpty) {
      final String decryptedStr = security.decryptString(data);
      List<dynamic> lst = json.decode(decryptedStr); 
      for (int i = 0; i < lst.length; i++) {
        Pwd pwd = Pwd.fromJson(jsonDecode(lst[0]));
        entries.add(pwd);
      }
    }
    
    return entries;
  }

  void saveData(List<Pwd> pwds) async {
    var security = Security();
    String k = await utils.getSecureData('priKey');
    security.priKey = k.substring(0, 32);
    data = security.encryptString(jsonEncode(pwds));
  }

  void syncJob() {

  }

  void syncNow() {

  }

}