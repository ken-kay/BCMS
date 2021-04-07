import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:bcms_app/admin/admin_home.dart';
import 'package:bcms_app/screens/home/home.dart';
import 'package:bcms_app/screens/schedule/calendar.dart';
//import 'package:bcms_app/screens/practice/practice.dart';
//import 'package:bcms_app/screens/practice/track.dart';
import 'package:bcms_app/screens/sheets/instruments.dart';
import 'package:bcms_app/screens/homework/to_do.dart';
import 'package:bcms_app/screens/track/attendance.dart';
//for sign out function
import 'package:bcms_app/services/auth.dart';

class AdminSide extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
              ),
            ),
            decoration:BoxDecoration(
                color:Colors.white,
                image: DecorationImage(
                    fit:BoxFit.fill,
                    // Change this later
                    image:AssetImage('assets/app-bg.png')
                )
            ),
          ),


          ListTile(
            leading: Icon(Icons.home),
            title: Text('AdminHome'),
            onTap: (){
              //go to Home page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>AdminHome()),
              );
            },
          ),
///*
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Schedule'),
            onTap: (){
              //go to Schedule page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Calendar()),
              );
            },
          ),

  //       */

          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Assignments'),
            onTap: ()=>{
              //go to Assignments page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Homework()),
              ),
            },
          ),


          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Sheet Music'),
            onTap: (){
              //go to Sheets page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Sheets()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.event_note),
            title: Text('Attendance'),
            onTap: (){
              //go to Record page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Attendance()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Return to Student App'),
            onTap: (){
              //go to Record page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Home()),
              );
            },
          ),

          //logout function
          FlatButton.icon(
            icon:Icon(Icons.person),
            //color: Colors.white,
            label: Text('Sign Out'),
            onPressed:() async{
              await _auth.signOut();
            },
          ),


        ],
      ),
    );
  }
}
