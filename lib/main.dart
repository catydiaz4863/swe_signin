import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<String> login(String username, String password) async {
    //try to login to https://sleepy-hamlet-97922.herokuapp.com/api/login
    final response = await http.get('https://sleepy-hamlet-97922.herokuapp.com/api/login?username=$username&password=$password');
    //if successful, that is, status is 200
    if(response.statusCode == 200)
    {
      Map<String, dynamic> serverData = json.decode(response.body);
      return serverData["token"];
    }
    else
    {
      return null;
    }
    //parse the response
    //return the token
    
    //if not successful return null
    
  }

  Future<String> getSecretMessage(String token) async {
    //try to retrieve secret
    //set HttpHeaders.authorizationHeader to Bearer token
   
    //if successful, that is, status is 200
    //parse the response
    //return the secret message
    //if not successful, return null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: usernameCtrl,
          ),
          TextField(
            controller: passwordCtrl,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: () async {
              //Try to login and retrieve token
              String token = await login(usernameCtrl.text, passwordCtrl.text);

              //if token is valid
              if (token != null) {

                //try to fetch the secret info
                String secret = await getSecretMessage(token);

                //if successfully retrieved
                if (secret != null) {

                  //navigate to MainScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen(secret)),
                  );
                }
              }
            },
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: () {
              //navigate to
              //MainScreen("Secret constructor message")

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MainScreen("Secret constructor message")),
              );
            },
          )
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  String secretMessage;

  MainScreen(this.secretMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confidential"),
      ),
      body: Text(secretMessage),
    );
  }
}

