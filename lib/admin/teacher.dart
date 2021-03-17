import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';


class PinPutTest extends StatefulWidget {
  @override
  PinPutTestState createState() => PinPutTestState();
}

class PinPutTestState extends State<PinPutTest> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.green,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(20.0),
                      child: PinPut(
                        fieldsCount: 5,
                        onSubmit: (String pin) => _showSnackBar(pin, context),
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => _pinPutFocusNode.requestFocus(),
                          child: const Text('Focus'),
                        ),
                        FlatButton(
                          onPressed: () => _pinPutFocusNode.unfocus(),
                          child: const Text('Unfocus'),
                        ),
                        FlatButton(
                          onPressed: () => _pinPutController.text = '',
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

/*
import 'package:flutter/material.dart';

InputDecoration inputFormat(Color fillColor){
  return new InputDecoration(
    fillColor: fillColor,
    filled: true,
    border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(12.0),
        borderSide: new BorderSide(width: 0.0, color: fillColor)
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  );
}

TextStyle textStyle(double fontSize, Color color, FontWeight fontWeight){
  return new TextStyle(
      color: color,
      decoration: TextDecoration.none,
      fontSize: fontSize,
      fontWeight: fontWeight
  );
}

Container pinBox(double width, TextEditingController con, FocusNode focusNode,
    FocusNode nextFocusNode, Color boxColor, Color textColor, BuildContext context, bool show) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3.0),
    width: width,
    child: new TextField(
      decoration: inputFormat(boxColor),
      controller: con,
      textAlign: TextAlign.center,
      cursorColor: boxColor,
      maxLines: 1,
      onChanged: (text) {
        if (text.length > 1) {
          con.text = text.substring(text.length - 1);
        }
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      obscureText: !show,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      autofocus: false,
      style: textStyle(30.0, textColor, FontWeight.bold),
    ),
  );
}

List<Widget> pinBoxs(double width, List<TextEditingController> cons,
    Color boxColor, Color textColor, BuildContext context, bool show) {
  List<Widget> boxs = new List();
  List<FocusNode> focusNodes = new List();
  focusNodes.add(new FocusNode());
  for(int i = 0; i < cons.length ; i++){
    focusNodes.add(new FocusNode());
    if(i == cons.length - 1){
      focusNodes[i+1] = null;
    }
    boxs.add(pinBox(width, cons[i], focusNodes[i], focusNodes[i+1], boxColor, textColor,context, show));
  }
  return boxs;
}




class Teacher extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PinBox Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'PinBox Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<TextEditingController> controllers = <TextEditingController>[new TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pinBoxs(50.0, controllers, Colors.white, Colors.black, context, false),
        ),
      ),
    );
  }
}


 */

/*

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:bcms_app/shared/loading.dart';
//import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/shared/constants.dart';
//import 'package:bcms_app/admin/admin_sign_in.dart';
import 'package:bcms_app/admin/admin_home.dart';
import 'package:flutter/services.dart';

/*
int ode = 123456;
String codeValidator(String code){
  if(code==null){
    return null;
  }
  final c = num.tryParse(code);
  if(c==null){
    return '"$code" is incorrect';
  }
  return null;
}


class Teacher extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TeacherState();
  }
}

class TeacherState extends State<Teacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Enter the code"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              RaisedButton(
                padding: const EdgeInsets.all(20.0),
                textColor: Colors.white,
                color: Colors.purpleAccent,
                onPressed: (){
                  if(code==ode){

                  }
                },
              )
            ],
          )),
    );
  }
}


*/
class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  //TextEditingController admin = TextEditingController();
  //TextEditingController pass = TextEditingController();
  TextEditingController code = TextEditingController();
  int passCode = 12345678;

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
                    controller: code,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code',
                    ),
                  ),
                ),

                /*
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

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
                  RaisedButton(
                    onPressed: () {
                      if (code == ode) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminHome()
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Enter code"),
                              );
                            });
                      }
/*
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Teachers'),
                    onTap: (){
                      if(
                      //admin=='mrsmith@gmail.com',
                      //pass=='smith1234'
                      code==passCode
                      )
                      //go to Record page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>AdminHome()),
                        //builder:(context)=>Move()),
                      );
                    },
                  ),

 */

                      /*
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
                */
                    }),
              ],
            )));
  }
}
*/

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
                  //async
                  {
                    // /*
                    if(
                     email=='admin@ueab.ke'&& password=='admin1234'
                     //email==a && password==b
                    )

                     // */
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


