import 'package:flutter/material.dart';

import 'package:pin_view/pin_view.dart';
import 'admin_home.dart';

//for pullout menu
import 'package:bcms_app/models/side.dart';


//setting the access code
String code = '1234';


class Pin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SafeArea (
          child: Container (
              padding: EdgeInsets.all(20.0),
              child: Column (
                  children: <Widget> [
                    //creates an icon at the top of the page
                    Icon(
                      //Icons.lock_open_outlined,
                        Icons.supervisor_account_sharp,
                        size:  150.0,
                        color:  Colors.black,
                    ),
                    Container(margin:  EdgeInsets.symmetric(vertical:  5.0)
                    ),
                    Text (
                        "Admin Access",
                        style: TextStyle (
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        )
                    ),
                    Container(
                        margin:  EdgeInsets.symmetric(vertical:  25.0)
                    ),
                    PinView (
                        count: 4, // number of digits
                        dashPositions: [1,2,3], // positions of dashes
                        autoFocusFirstField: false,
                        margin: EdgeInsets.all(2.0),
                        obscureText: true,
                        style: TextStyle (
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900
                        ),
                        dashStyle: TextStyle (
                          // dash style
                            fontSize: 30.0,
                            color: Colors.black38
                        ),


                        //checks entered pin and allows another attempt on failure
                        submit: (String pin) {
                          if(pin == code)
                            //code = 1234
                              {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>AdminHome()),
                            );
                          }
                          else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>Pin()),
                            );
                          }
                        }
                    )
                  ]
              )
          ),
      ),
      //for the menu
      drawer: Side(),
    );
  }
}