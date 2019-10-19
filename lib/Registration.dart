import 'package:authentication_lab/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Listpage.dart';
class RegistrationPage extends StatelessWidget {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  void register(String username, String password) async {
    //try to login to https://sleepy-hamlet-97922.herokuapp.com/api/register
    final response = await http.post(
        'https://sleepy-hamlet-97922.herokuapp.com/api/register?username=$username&password=$password');
    if (response.statusCode == 201) {
    } else {
      print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFB367),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(),
            child: Text("Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
            child: TextFormField(
              controller: usernameCtrl,
              decoration: InputDecoration(
                labelText: 'Email: ',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
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
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: RaisedButton(
              child: Text("Register",
              style: TextStyle(color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ), 
              ),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              color: Color(0xFF244454),
              onPressed: () async {

              register(usernameCtrl.text, passwordCtrl.text);
            
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
