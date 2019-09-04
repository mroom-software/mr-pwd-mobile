class UserFeedback {
  String name;
  String email;
  String subject;
  String message;
  String app;
  String version;
  String platform;

  UserFeedback(
      {this.name,
      this.email,
      this.subject,
      this.message,
      this.app,
      this.version,
      this.platform});

  factory UserFeedback.fromJson(Map<String, dynamic> json) {
    return UserFeedback(
      name: json['Name'],
      email: json['Email'],
      subject: json['Subject'],
      message: json['Message'],
      app: json['App'],
      version: json['Version'],
      platform: json['Platform'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["Name"] = name;
    map["Email"] = email;
    map["Subject"] = subject;
    map["Message"] = message;
    map["App"] = app;
    map["Version"] = version;
    map["Platform"] = platform;

    return map;
  }
}
