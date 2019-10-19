import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Listpage.dart';
import 'models.dart';

class CreateNote extends StatefulWidget {

  CreateNote(this.todo_items, this.token);
    List<TodoItem>todo_items;
  dynamic token;
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController titleCtrl = TextEditingController();

  TextEditingController descriptionCtrl = TextEditingController();



  Future sumbit(String title, String description, dynamic token) async {
     final response = await http.post(
        'https://sleepy-hamlet-97922.herokuapp.com/todo_items?text=$title',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );
    if (response.statusCode == 201) {
      print("it worked");
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Item"),
        backgroundColor: Color(0xFFEFB367),
      ),
      body: Center(
        child: new Column(
          children: <Widget>[
            Padding(
              // FOR THE TITLE
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
              child: TextFormField(
                controller: titleCtrl,
                decoration: InputDecoration.collapsed(hintText: 'Title'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              child: TextField(
                controller: descriptionCtrl,
                decoration:
                    new InputDecoration.collapsed(hintText: 'Description...'),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 160),
                child: RaisedButton(
                  color: Color(0xFF244454),
                  child: Text(
                    "Sumbit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  onPressed: () {
                    print(widget.token);
                    sumbit(titleCtrl.text, descriptionCtrl.text, widget.token);
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new Listpage(widget.todo_items, widget.token)),
                    );
                  },
                  
                )
                )
          ],
        ),
      ),
    );
  }
}
