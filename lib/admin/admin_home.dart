import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/models/side.dart';
import 'package:bcms_app/models/music.dart';
import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/services/database.dart';
import 'package:bcms_app/screens/music/music_list.dart';
//import 'package:bcms_app/screens/home/wrapper.dart';
//import 'package:bcms_app/screens/music/settings_form.dart';
//moved this one to home
import 'package:bcms_app/screens/music/choose.dart';
import 'package:bcms_app/screens/practice/practice.dart';
import 'package:bcms_app/admin/admin_side.dart';

class AdminHome extends StatelessWidget {
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
          title: Text('Admin'),
          backgroundColor:Colors.black,
          elevation:0.0,
          actions: <Widget>[
            
            TextButton.icon(
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
        /*
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

         */
        //tried to fix the error I was getting before, canceling the redundancy
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/waiting.png'),
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



/*
//old admin home
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/admin/admin_side.dart';
import 'package:bcms_app/screens/music/music_list.dart';
import 'package:bcms_app/screens/music/choose.dart';
import 'package:bcms_app/models/music.dart';
import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/services/database.dart';
import 'package:bcms_app/screens/practice/practice.dart';

class AdminHome extends StatelessWidget {

/*
class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/waiting.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: MusicList()
      ),
        drawer: AdminSide(),
    );

  }
}


 */