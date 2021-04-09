import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:bcms_app/screens/home/home.dart';
import 'package:bcms_app/screens/homework/to_do.dart';
import 'package:bcms_app/screens/sheets/instruments.dart';
import 'package:bcms_app/screens/practice/track.dart';
//for sign out function
import 'package:bcms_app/services/auth.dart';
//connect to the teacher side
import 'package:bcms_app/admin/access.dart';

class Side extends StatelessWidget {
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
                  fontSize: 40.0
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
            title: Text('Home'),
            onTap: (){
              //go to Home page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Home()),
              );
            },
          ),


          ListTile(
            tileColor: Colors.black12,
            leading: Icon(Icons.assignment),
            title: Text('Homework'),
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
            tileColor: Colors.black12,
            leading: Icon(Icons.event_note),
            title: Text('Practice'),
            onTap: (){
              //go to Practice page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Track()),
              );
            },
          ),


          ListTile(
            leading: Icon(Icons.account_balance_outlined),
            title: Text('Teachers'),
            onTap: (){
              //go to Record page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>Pin()),
              );
            },
          ),


          //logout function
          FlatButton.icon(
            icon:Icon(Icons.close),
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
