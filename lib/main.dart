import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_lab/Registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Registration.dart';
import 'Listpage.dart';
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
    final response = await http.get(
        'https://sleepy-hamlet-97922.herokuapp.com/api/login?username=$username&password=$password');
    //if successful, that is, status is 200
    if (response.statusCode == 200) {
      Map<String, dynamic> serverData = json.decode(response.body);
      return serverData["token"];
    } else {
      return null;
    }
    //parse the response
    //return the token

    //if not successful return null
  }

  void register(String username, String password) async {
    //try to login to https://sleepy-hamlet-97922.herokuapp.com/api/register
    final response = await http.post(
        'https://sleepy-hamlet-97922.herokuapp.com/api/register?username=$username&password=$password');
    if (response.statusCode == 201) {
    } else {
      print(response.body);
    }
  }

  Future<String> getSecretMessage(String token) async {
    //try to retrieve secret
    //set HttpHeaders.authorizationHeader to Bearer token
    final response = await http.get(
      'https://sleepy-hamlet-97922.herokuapp.com/secret',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      Map<String, dynamic> secret = json.decode(response.body);
      print("it worked");
      return secret["message"];
    } else {
      print("it didnt work");
      return null;
    }
    //if successful, that is, status is 200
    //parse the response
    //return the secret message
    //if not successful, return null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF244454),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(),
            child: Text(
              "TODO-LIST",
              style: TextStyle(color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
              ),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
            child: TextFormField(
              controller: usernameCtrl,
              decoration: InputDecoration(
                labelText: 'Email: ',
               labelStyle: TextStyle(color: Color(0xFFEFB367), fontSize: 20),
                contentPadding: EdgeInsets.symmetric(vertical: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                labelText: 'Password: ',
                contentPadding: EdgeInsets.symmetric(vertical: 25),
                labelStyle: TextStyle(color: Color(0xFFEFB367), fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: RaisedButton(
              child: Text("Sign in",
              style: TextStyle(color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ), 
              ),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              color: Color(0xFFEFB367),
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
                      MaterialPageRoute(builder: (context) => Listpage()),
                    );
                  }
                }
              },
            ),
          ),
         
          new Container(
          
            child: RaisedButton(
              child: Text("Register",
              style: TextStyle(color: Color(0xFFEFB367),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,),
                  ),
                 
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  color: Color(0xffEFB367).withOpacity(0.2),
                  
              onPressed: () {
                //navigate to
                //MainScreen("Secret constructor message")
                register(usernameCtrl.text, passwordCtrl.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationPage()),
                );
              },
            ),
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
