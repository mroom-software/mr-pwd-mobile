import 'package:encrypt/encrypt.dart';

class PrivateKeyException implements Exception { 
   String errMsg() => 'Private key is invalid'; 
}

class Security {
  final iv = IV.fromLength(16);

  String priKey;
  Security({this.priKey});

  String encryptString(String data) {
    if (priKey == null) {
      throw new PrivateKeyException();
    }
    
    final key = Key.fromUtf8(priKey) ;
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(data, iv: iv).base64;
  }

  String decryptString(String encryptedData) {
    if (priKey == null) {
      throw new PrivateKeyException();
    }

    final key = Key.fromUtf8(priKey) ;
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(encryptedData, iv: iv);
  }
}