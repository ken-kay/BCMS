import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/models/user.dart';
import 'package:bcms_app/screens/home/wrapper.dart';
import 'package:bcms_app/services/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //doesn't seem needed now:
  // const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //This part is for the login functions
    return StreamProvider<User>.value(
      value:AuthService().user,
      child: MaterialApp(
        //theme:ThemeData.dark(), doesn't present well
          theme:ThemeData(primaryColor: Colors.black),
          home: Wrapper(),
      ),
    );
  }
}


