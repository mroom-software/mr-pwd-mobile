
class User {
  int id;
  String name;
  String password;
  // final String privKey; // https://pub.dev/packages/flutter_secure_storage
  
  User({this.id, this.name, this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    password = map['password'] as String;
  }
}