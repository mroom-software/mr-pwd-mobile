//"ID": 2,
//"Name": "2048",
//"DisplayName": "2048",
//"ImageURL": "https://storage.googleapis.com/www.mroomsoft.com/img/icons/2048.jpg",
//"IOS": "https://apps.apple.com/us/app/my-2048-the-game-of-numbers/id904298155",
//"Android": ""
class Game {
  int id;
  String name;
  String displayName;
  String imgUrl;
  String iosLink;
  String androidLink;

  Game({this.id, this.name, this.displayName, this.imgUrl, this.iosLink, this.androidLink});

  Game.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        name = json['Name'],
        displayName = json['DisplayName'],
        imgUrl = json['ImageURL'],
        iosLink = json['IOS'],
        androidLink = json['Android'];
}


