
class User {
  int id;
  String name;
  String password;
  String chainID;
  String network;
  String data;
  int syncTime;
  
  User({this.id, this.name, this.password, this.chainID, this.network, this.data, this.syncTime});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'chainID': chainID,
      'network': network ?? 'eos',
      'data': data,
      'syncTime': syncTime,
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
  }

  @override
  String toString() {
    return ('${this.id} - ${this.name} - ${this.password} - ${this.chainID} - ${this.network} - ${this.data} - ${this.syncTime}');
  }

}