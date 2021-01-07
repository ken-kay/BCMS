import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:bcms_app/shared/loading.dart';
import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth =AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;

  //text field state
  String email='';
  String password='';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Register for BCMS App'),
        actions: <Widget>[
          FlatButton.icon(
              icon:Icon(Icons.person),
              color:Colors.white,
              label: Text('Sign In'),
              onPressed: ()=> widget.toggleView(),

              //Trying to fix the register part
              //onPressed: (){
            //                widget.toggleView();
            //              }


          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
        /*child: RaisedButton(child:Text('Sign in Anon'),onPressed: () async{dynamic result = await _auth.signInAnon();if(result==null){print('error signing in');}else {print('signed in');print(result.uid);}},)*/
        child:Form(
          key: _formKey,
          child:Column(
              children:<Widget>[
                SizedBox(height:20.0),
                TextFormField(
                  //use this line anywhere there's a validation box
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
                    validator: (val)=>val.length <6? 'Enter a password 6+ chars long' : null,
                    onChanged: (val){
                      setState(()=>password=val);
                    }
                ),
                SizedBox(height:20.0),
                RaisedButton(
                    color:Colors.pink,
                    child:Text(
                      'Register',
                      style:TextStyle(color:Colors.white),
                    ),
                    onPressed: ()async {
                      if (_formKey.currentState.validate()){
                        setState(()=>loading=true);
                        dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                        if(result==null){
                          setState(() {
                            error='Please supply a valid email';
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
              ],
          ),

        ),
      ),

    );
  }
}
