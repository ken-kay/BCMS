import 'package:flutter/material.dart';
import 'package:bcms_app/screens/track/record.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Records',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: Record(),
    );
  }
}









/*
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
//import 'package:url_launcher/url_launcher.dart';
import 'package:beautifulsoup/beautifulsoup.dart';
//dunno if I need the http feature
//import 'package:http/http.dart'; as http;


class Attendance extends StatefulWidget {
  Attendance();

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override

  void initState(){
    getDetailsFromStorage();
    super.initState();
  }

  var rollNo = 0;
  var classroom = '';
  var name = 'Attendance';
  var timeTable = [];
  var numClasses = [];
  var subject = [];
  var numSubjects;
  var studentPresent = [];
  var back = 0;

  //trying to get this working:
getDetailsFromStorage() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  classroom = pref.getString('room');
  var roll = pref.get('rollNum');
  rollNum = int.parse(roll);

  getData();
}

  @override
  Widget build(BuildContext context){
  return WillPopScope(
    onWillPop: () async{
      if(back==1)
        Navigator.pushReplacementNamed(
            context, '/choose');
      else
        return true;
      return false;
    },
    child: MaterialApp(
      title: 'Tracking',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
    ),
    home: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FloatingActionButton.extended(
              onPressed: null,
              label: null
          ),
        ],

        ),

      ),
    ),
    );

  }

  //Attendance
getAttendanceFeed(){
  setState(() {
    mainElement=<Widget>[];
    mainElement=returnListOfAttendanceInfo(
      studentPresent,
      subject,
      numSubjects,
      numClasses,
      context
    );
    if(studentPresent.length !=0){
      try{
        studentPresent[0]=studentPresent[0]
            //.toLowerCase()

      }catch(_){}
      name=studentPresent[0];
      back=0;
    }
  });
}

//trying the database function
convertData(track){
  //var tablelist=track.find_all("table").map((e)=>.toList)
}


}


 */