
class User {
  int id;
  String name;
  String password;
  String chainID;
  String network;
  
  User({this.id, this.name, this.password, this.chainID, this.network});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'chainID': chainID,
      'network': network ?? 'eos',
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    password = map['password'] as String;
    chainID = map['chainID'] as String;
    network = map['network'] as String;
  }

  @override
  String toString() {
    return ('${this.id} - ${this.name} - ${this.password} - ${this.chainID} - ${this.network}');
  }

}