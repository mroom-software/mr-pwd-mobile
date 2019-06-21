import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:blockpass/config/app.dart';
import 'package:dio/dio.dart';

class BPApi {

  final chars = "abcdefghijklmnopqrstuvwxyz12345";
  static final BPApi _singleton = new BPApi._internal();
  Dio _dio;
  final String _baseUrl = app.baseURL;

  factory BPApi() {
    return _singleton;
  }

  BPApi._internal() {
    _dio = new Dio();
  }

  Future<Map<String, dynamic>> getMoreApps(String source) async {
    try {
      Response response = await _dio.get(_baseUrl + '/system/more-apps?source=' + source);
      return json.decode(response.data.toString());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> sendFeedback(String email, String name, String message) async {
    try {
      FormData formData = new FormData.from({
        'Email': 'trongdth@gmail.com',
        'Name': 'Trong Dinh',
        'Message': 'hello',
      });
      Response response = await _dio.post(_baseUrl + '/system/contact-us', data: formData);
      return json.decode(response.data.toString());
    } catch (e) {
      print(e);
      return null;
    }
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
    http.get('http://faucet.cryptokylin.io/create_account?$accountName').then((http.Response response) {
      if (response.statusCode >= 300) {
        completer.completeError(response.body);
      } else {
        completer.complete(json.decode(response.body));
      }
    });
    return completer.future;
  }

}