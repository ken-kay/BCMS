import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/models/music.dart';
import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/services/database.dart';
import 'package:bcms_app/screens/music/music_list.dart';
//Admin pullout
import 'package:bcms_app/admin/admin_side.dart';

class AdminHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Music>>.value(
      value:DatabaseService().musics,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('Admin'),
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

        //tried to fix the error I was getting before, canceling the redundancy
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/admin_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: MusicList()
        ),
        drawer: AdminSide(),
      ),
    );
  }
}


