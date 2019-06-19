
class Pwd {
  String name;
  String url;
  String email;
  String password;
  String notes;

  Pwd({this.name, this.url, this.email, this.password, this.notes});

  String toString() {
    return '${this.name} - ${this.url} - ${this.email} - ${this.password} - ${this.notes}';
  }

  String toJson() {
    return '{"name": "$name", "url": "$url", "email": "$email", "password": "$password", "notes": "$notes"}';
  }

  factory Pwd.fromJson(Map<String, dynamic> json) {
    return Pwd(
      name: json['name'] as String,
      url: json['url'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      notes: json['notes'] as String,
    );
  }
}