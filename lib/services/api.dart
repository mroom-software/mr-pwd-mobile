import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:blockpass/config/app.dart';
// import 'package:dio/dio.dart';

class BPApi {

  final chars = "abcdefghijklmnopqrstuvwxyz12345";
  static final BPApi _singleton = new BPApi._internal();
  final String _baseUrl = app.baseURL;

  factory BPApi() {
    return _singleton;
  }

  BPApi._internal() {
  }

  String _randomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  Future createEOSAccount() async {
    String accountName = _randomString(12);
    Completer completer = Completer();
    http.get('http://faucet.cryptokylin.io/create_account?$accountName',
      headers: {
        'Accept': 'application/json',
      },
    )
      .timeout(const Duration(seconds: 6))
      .then((http.Response response) {
      if (response.statusCode >= 300) {
        completer.completeError(response.body);
      } else {
        completer.complete(json.decode(response.body));
      }
    });
    return completer.future;
  }

}