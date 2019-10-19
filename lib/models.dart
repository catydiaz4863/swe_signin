import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoItem{
int id;
String text;
bool completed;
int user_id;

TodoItem({this.id, this.text, this.completed, this.user_id});

Future toggle(token) async {
  completed = !completed;

  var response = await http.patch('https://sleepy-hamlet-97922.herokuapp.com/todo_items/${id}?completed=${completed}',
  headers: {HttpHeaders.authorizationHeader: "Bearer $token"}
  );
  if(response.statusCode !=200)
  {
    completed = !completed;
  }
}


factory TodoItem.fromJson(Map<String,dynamic> json){
    return TodoItem(
        id: json["id"],
        text: json["text"],
        completed: json["completed"],
        user_id: json["user_id"],

    );
}

}

