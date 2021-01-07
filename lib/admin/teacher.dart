import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:bcms_app/shared/loading.dart';
//import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/shared/constants.dart';
//import 'package:bcms_app/admin/admin_sign_in.dart';
import 'package:bcms_app/admin/admin_home.dart';


class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  TextEditingController admin = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'BCMS',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in to Admin Portal',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: admin,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                /*
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                    //
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        //print(admin.text);
                        //print(pass.text);
                        AdminHome();
                      },
                    )),
                //

                   */
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Teachers'),
                    onTap: (){
                      //go to Record page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>AdminHome()),
                        //builder:(context)=>Move()),
                      );
                    },
                  ),

                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.lightGreenAccent[400],
                          child: Text(
                            'Enter',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            //AdminHome();


                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))

              ],
            )));
  }
}



/*
class Teacher extends StatefulWidget {

  final Function toggleView;
  Teacher({this.toggleView});
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  //not sure about this one
  //final AuthService _admin = AuthService();
  //final _adminKey = GlobalKey<FormState>();
  //bool loading =false;
  String email='';
  String password='';
  String error='';

  //final String a = 'admin@ueab.ke';
  String a = 'admin@ueab.ke';
  //final String b = 'admin1234';
  String b = 'admin1234';

  @override
  Widget build(BuildContext context) {
    //return loading ? Loading():Scaffold(
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        elevation: 0.0,
        title: Text('Admin Sign In'),
        /*
          actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.arrow_back,
            color:Colors.white),
            label: Text('Return to Student App'),
            onPressed: (){
              Home();
            },
          )
        ],
        */
      ),

      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0
        ),
        child: Form(
          //key: _adminKey,
          child: Column(
            children:<Widget> [
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val)=>val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(()=>email=val);
                  }
              ),
              SizedBox(height:20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val)=>val.length <6? 'Enter a password 6+ chars long':null,
                  onChanged: (val){
                    setState((){
                      password=val;
                    });
                  }
              ),
              SizedBox(height:20.0),
              RaisedButton(
                  color:Colors.lightGreenAccent,
                  child:Text(
                    'Sign in as Admin',
                    style:TextStyle(color:Colors.black),
                  ),
                  onPressed: ()
                  async
                  {
                    /*
                    if(
                     email=='admin@ueab.ke'&& password=='admin1234'
                     //email==a && password==b
                    )

                     */
                      AdminHome();
                  }
              ),
            ],
          ),
        ),
      ),

    );
  }
}


 */


/*
Created a teacher account
mrsmith@gmail.com
smith1234

The Admin login
admin@ueab.ke
admin1234
 */
