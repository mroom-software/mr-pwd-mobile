import 'dart:convert';

import 'package:blockpass/config/app.dart';
import 'package:dio/dio.dart';

class BPApi {

  static final BPApi _singleton = new BPApi._internal();
  Dio _dio;
  final String _baseUrl = app.baseURL;

  factory BPApi() {
    return _singleton;
  }

  BPApi._internal() {
    _dio = new Dio();
  }

  Future<Map<String, dynamic>> getMoreApps() async {
    try {
      Response response = await _dio.get(_baseUrl + '/system/more-apps');
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

}