import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/screens/practice/log.dart';
import 'package:bcms_app/models/side.dart';
import 'package:bcms_app/screens/practice/practice.dart';

class Track extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Practice Practice Practice'),
        ),
        body: Center(
          child: Column(
            children:<Widget> [
              Container(

              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Practice Session'),
          icon: Icon(Icons.event_note),
          backgroundColor: Colors.green,
          onPressed: (){
            Navigator.push(
            context,
          MaterialPageRoute(
            builder: (context)=>Practice()),
            );
          },
        ),

        drawer: Side(),
      ),
    );
  }
}
