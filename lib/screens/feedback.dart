import 'dart:io';

import 'package:blockpass/services/feedback.dart';
import 'package:blockpass/services/response.dart';
import 'package:blockpass/utils/utils.dart';
import 'package:blockpass/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        bottomOpacity: .2,
        title: Text(
          'FEEDBACK',
          style: Theme.of(context).textTheme.title,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: FeedbackForm()

    );
  }
}

class FeedbackForm extends StatefulWidget {
  @override
  FeedbackFormState createState() {
    return FeedbackFormState();
  }
}

class FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  UserFeedback feedback = UserFeedback();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your name.",
                labelText: "Full name",
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
              onSaved: (value) {
                feedback.name = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Enter your email.",
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your email.';
                } else {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value))
                    return 'Please enter a valid email.';
                }

                return null;
              },
              onSaved: (value) {
                feedback.email = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Type in the subject.",
                labelText: "Subject",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please input the subject.';
                }
                return null;
              },
                onSaved: (value) {
                  feedback.subject = value;
                }
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Write down something you want to send to us.",
                labelText: "Content",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Let type in somethings.';
                }
                return null;
              },
                onSaved: (value) {
                  feedback.message = value;
                }
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            width: double.infinity,
            child: RaisedButton(
              padding: EdgeInsets.all(12.0),
              color: Color.fromRGBO(36, 59, 107, 1),
              child: Text(
                  "SEND",
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  feedback.platform = Utils.getOsPlatform();
                  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                    feedback.app = packageInfo.appName;
                    feedback.version = packageInfo.version;
                    try {
                      Future<ResponseModel> future = sendFeedback(body: feedback.toMap());
                      future.then((responseModel) {
                        if (responseModel.error != null) {
                          Utils.showPopup(context, "Error", responseModel.error.message);
                        } else {
                          Utils.showPopup(context, "", "We really appreciate your feedback.");
                        }
                      });

                    }
                    on Exception catch(e) {
                      Utils.showPopup(context, "Error", 'Cannot connect the server. Please try again later');
                    }
                  });

                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<ResponseModel> sendFeedback({Map body}) async {

    String url = "$kBaseUrl/contact-us";
    return await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json.encode(body))
        .then((http.Response response) {

          final int statusCode = response.statusCode;

          return ResponseModel.fromJson(json.decode(response.body));
        })
        .catchError((onError) {
          Utils.showPopup(context, "Error", 'Cannot connect the server. Please try again later');
        });

  }
}
