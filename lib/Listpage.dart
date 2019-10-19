import 'dart:convert';
import 'dart:io';

import 'package:authentication_lab/CreateNote.dart';
import 'package:authentication_lab/models.dart';
import 'package:flutter/material.dart';
import 'CreateNote.dart';
import 'package:http/http.dart' as http;

class Listpage extends StatefulWidget {
//functions go here

  List<TodoItem> todo_items;

  dynamic token;

  Listpage(this.todo_items, this.token);

  @override
  _ListpageState createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  TextEditingController _textFieldController = TextEditingController();

  Future<String> update(dynamic token, String itemText, int item) async {
    //try to retrieve secret

    //set HttpHeaders.authorizationHeader to Bearer token
    final response = await http.patch(
      'https://sleepy-hamlet-97922.herokuapp.com/todo_items/${item}?text=$itemText',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    print(token);
    print(itemText);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      Map<String, dynamic> secret = json.decode(response.body);
      print("it worked");
    } else {
      print(response.body);
      return null;
    }
    //if successful, that is, status is 200
    //parse the response
    //return the secret message
    //if not successful, return null
  }

  Future<String> delete(dynamic token, int item) async {
    //try to retrieve secret

    //set HttpHeaders.authorizationHeader to Bearer token
    final response = await http.delete(
      'https://sleepy-hamlet-97922.herokuapp.com/todo_items/${item}',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    print(token);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      Map<String, dynamic> secret = json.decode(response.body);
      print("it worked");
    } else {
      print(response.body);
      return null;
    }
    //if successful, that is, status is 200
    //parse the response
    //return the secret message
    //if not successful, return null
  }

  _displayDialog(BuildContext context, dynamic item) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Text'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Describe..."),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('DELETE'),
                onPressed: () {
                  delete(widget.token, item.id);
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
              new FlatButton(
                child: new Text('SUMBIT'),
                onPressed: () {
                  update(widget.token, _textFieldController.text, item.id);
                  item.text = _textFieldController.text;
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
              new FlatButton(
                child: new Text('DELETE'),
                onPressed: () {
                  delete(widget.token, item.id);
                  Navigator.of(context).pop();
                  setState(() {});
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO-LIST"),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF244454),
      ),
      body: ListView.builder(
        itemCount: widget.todo_items.length,
        itemBuilder: (BuildContext context, int index) {
          TodoItem item = widget.todo_items[index];
          return CheckboxListTile(
            title: Text(item.text),
            value: item.completed,
            onChanged: (value) {
              item.toggle(widget.token);
              setState(() {});
            },
            secondary: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _displayDialog(context, item),
            ),
          );
        },
      ),

      ///////////
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF244454),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: IconButton(
                icon: Icon(Icons.add_circle),
                iconSize: 50,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateNote(widget.todo_items, widget.token)),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Icon(
                Icons.contacts,
                size: 50,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Icon(
                Icons.calendar_today,
                size: 50,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Icon(
                Icons.share,
                size: 50,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
