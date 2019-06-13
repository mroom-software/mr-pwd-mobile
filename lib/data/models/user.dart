
class User {
  int id;
  String name;
  String password;
  String chainURL;
  // final String privKey; // https://pub.dev/packages/flutter_secure_storage
  
  User({this.id, this.name, this.password, this.chainURL});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'chainURL': chainURL,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    password = map['password'] as String;
    chainURL = map['chainURL'] as String;
  }
}