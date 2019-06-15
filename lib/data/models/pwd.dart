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

}