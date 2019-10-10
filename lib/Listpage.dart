import 'package:flutter/material.dart';

class Listpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TODO-LIST"),
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF244454),
      ),

      body: Column(
        children: <Widget>[

        ],
      ),
      bottomNavigationBar: BottomAppBar(child: Text("Bottom"), color: Color(0xFF244454),),
    );
  }
}