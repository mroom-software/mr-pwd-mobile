import 'game.dart';

class ResponseModel {
  final Error error;

  ResponseModel({this.error});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {

    return ResponseModel(
      error: json["Error"] != null ? Error.fromJson(json["Error"]) : null
    );
  }
}

class Error {
  final int code;
  final String message;

  Error({this.code, this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(code: json["Code"], message: json["Message"]);
  }
}

class GameResponse {
  final List<Game> result;
  final Error error;

  GameResponse({this.result, this.error});

  factory GameResponse.fromJson(Map<String, dynamic> data) {

    List<Game> games;
    if (data["Result"] != null) {
      Iterable list = data["Result"];
      games = list.map((model) => Game.fromJson(model)).toList();
    }

    return GameResponse(
        error: data["Error"] != null ? Error.fromJson(data["Error"]) : null,
        result: games
    );
  }
}