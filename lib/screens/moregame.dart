
import 'dart:convert';
import 'dart:io';

import 'package:blockpass/services/game.dart';
import 'package:blockpass/services/response.dart';
import 'package:blockpass/utils/constants.dart';
import 'package:blockpass/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MoreGameScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: .5,
          bottomOpacity: .2,
          title: Text(
            'MORE APPS',
            style: Theme.of(context).textTheme.title,
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: AppListScreen()

    );
  }
}

class AppListScreen extends StatefulWidget {
  @override
  createState() => _ListAppState();
}

class _ListAppState extends State {
  var games = new List<Game>();

  _getMoreGames() {
    getMoreGames().then((response) {
      setState(() {
        games = response.result;
      });
    });
  }

  initState() {
    super.initState();
    _getMoreGames();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {
    return ListView.separated(itemBuilder: (context, index) =>
        ListTile(
          leading: Image.network(games[index].imgUrl),
          title: Text(games[index].displayName),
          contentPadding: EdgeInsets.all(10.0),
          onTap: () => Utils.gotoWebsite(context, games[index].iosLink),),

        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.shade400,
        ),

      itemCount: games?.length ?? 0,
    );
  }

  Future getMoreGames() async {
    String url = "$kBaseUrl/more-apps";
    Map body = Map<String, String>();
    body["Name"] = kAppName;
    body["Platform"] = Utils.getOsPlatform();
    return await http
        .post(url,
            headers: {HttpHeaders.contentTypeHeader: "application/json"},
            body: json.encode(body))
            .then((http.Response response) {


          return GameResponse.fromJson(json.decode(response.body));
        })
        .catchError((onError) {

          Utils.showPopup(context, "Error", 'Cannot connect the server. Please try again later');

        });
  }
}
