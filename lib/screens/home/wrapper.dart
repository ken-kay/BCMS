import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/screens/authentication/authentication.dart';
import 'package:bcms_app/screens/home/home.dart';
import 'package:bcms_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    //return Home or Authenticate widget
    if (user==null){
      return Authenticate();
    }else {
      return Home();
    }
    //return Authenticate();
  }
}