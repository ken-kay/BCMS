import 'package:flutter/material.dart';

//import 'package:native_pdf_view/native_pdf_view.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';

import 'violin.dart';
import 'piano.dart';
import 'guitar.dart';

class Sheets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheet Music'),
      ),
      body: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Violin'),
                onTap: (){
                  //go to Home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>Violin()),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Piano'),
                onTap: (){
                  //go to Home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>Piano()),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Guitar'),
                onTap: (){
                  //go to Home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>Guitar()),
                  );
                },
              )
            ],
          ),
      ),
      drawer: Side(),
    );
  }
}

