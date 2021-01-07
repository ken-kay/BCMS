import 'package:flutter/material.dart';


import 'package:bcms_app/models/music.dart';
import 'package:bcms_app/models/user.dart';
import 'package:bcms_app/screens/authentication/sign_in.dart';
import 'package:bcms_app/screens/track/attendance.dart';

class MusicTile extends StatelessWidget {

  final Music music;
  //final User user= _auth.currentUser();
  MusicTile({this.music});

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius:25.0,
              backgroundColor: Colors.black12,
              backgroundImage: AssetImage('assets/icon.png'),
              //[music.practice],
            ),
            title:Text('${music.name}'),
            subtitle:Text('${music.studentId} is taking: ${music.instruments} lessons at ${music.hours}'),
            onTap: (){
              Attendance();
            },

          ),
        ),
    );
  }
}
