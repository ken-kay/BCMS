//import 'dart:async';
//import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:pin_view/pin_view.dart';
import 'admin_home.dart';

class Pin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: SafeArea (
            child: Container (
                padding: EdgeInsets.all(15.0),
                child: Column (
                    children: <Widget> [
                      Icon(
                          Icons.lock_open_outlined,
                          size:  100.0,
                          color:  Theme.of(context).primaryColor
                      ),
                      Container(margin:  EdgeInsets.symmetric(vertical:  5.0)),
                      Text (
                          "Admin Access",
                          style: TextStyle (
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      Container(margin:  EdgeInsets.symmetric(vertical:  5.0)),
                      PinView (
                          count: 4, // describes the field number
                          dashPositions: [1,2,3], // positions of dashes, you can add multiple
                          autoFocusFirstField: false, // defaults to true
                          margin: EdgeInsets.all(2.0), // margin between the fields
                          obscureText: true, // describes whether the text fields should be obscure or not, defaults to false
                          style: TextStyle (
                            // style for the fields
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500
                          ),
                          dashStyle: TextStyle (
                            // dash style
                              fontSize: 25.0,
                              color: Colors.grey
                          ),
                          submit: (String pin) {
                            //if(1234)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>AdminHome()),
                                );
                            }
                            // when all the fields are filled
                            // submit function runs with the pin
                            //print(pin);
                          }
                      )
                    ]
                )
            )
        )
    );
  }
}