import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/models/side.dart';
import 'package:bcms_app/models/music.dart';
import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/services/database.dart';
import 'package:bcms_app/screens/music/choose.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  //to change the text on the floating button
  //bool check = true;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Music>>.value(
      value:DatabaseService().musics,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('BCMS'),
          backgroundColor:Colors.black,
          elevation:0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person),
              color: Colors.white,
              label: Text('Sign Out'),
              onPressed:() async{
                  await _auth.signOut();
              },
            ),
          ],
        ),
        //For registration
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Register'),
          icon: Icon(Icons.music_note),
          backgroundColor: Colors.purple,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>ChooseForm()),
            );
          },
        ),

        //tried to fix the error I was getting before, canceling the redundancy
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image:DecorationImage(
                image: AssetImage('assets/bcms_logo.png'),
                ),
              ),
            ),
            //child: MusicList()
        ),
        drawer: Side(),
      ),
    );
  }
}


