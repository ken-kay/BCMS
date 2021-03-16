import 'package:flutter/material.dart';

import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/shared/loading.dart';
import 'package:bcms_app/shared/constants.dart';

//connect to the teacher side
//import 'package:bcms_app/admin/teacher.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth =AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
    //return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[          
          TextButton.icon(
            icon:Icon(Icons.person,
              color: Colors.black,
              ),
            label: Text('Register'),
            color:  Colors.white,
            onPressed: (){
              widget.toggleView();
            }
          )

        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
        child:Form(
          key: _formKey,
        child:Column(
          children:<Widget>[
            SizedBox(height:20.0),
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
            ElevatedButton(
              color:Colors.pink,
              child:Text(
                'Sign in',
                style:TextStyle(color:Colors.white),
              ),
              onPressed: ()async {
                if(_formKey.currentState.validate()){
                  setState(()=>loading=true);
                  dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                  if(result==null){
                  setState((){
                    error='Incorrect Credentials';
                    loading=false;
                  });
                  }
                }
              }
            ),

            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color:Colors.red,fontSize: 14.0),
            ),
          ]
        ),

      ),
     ),
      
    );
  }
}

/*created an account:
email:name@gmail.com
password: words1234

email: new@gmail.com
password: pass1234
*/

/*
Created a teacher account
mrsmith@gmail.com
smith1234
 */
