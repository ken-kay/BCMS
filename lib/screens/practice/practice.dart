import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:bcms_app/shared/constants.dart';
import 'package:bcms_app/screens/practice/daily_db.dart';
import 'package:bcms_app/screens/practice/daily.dart';
import 'package:bcms_app/screens/practice/log.dart';


class Practice extends StatefulWidget {
  @override
  _PracticeState createState() {
    return _PracticeState();
  }
}

class _PracticeState extends State<Practice> {
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _dailyKey = GlobalKey<FormBuilderState>();

  final List<String> time=[
    '6:00',
    '7:00',
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];

  final List<String> room=[
    'Room 1',
    'Room 2',
    'Room 3',
    'African Room'
    'Band Room'
  ];

  final List<String> borrow=[
    'Yes',
    'No',
  ];

  final List<String> borrowed=[
    'Yes',
    'No',
  ];

  //keep track of form values
  String _currentTime;
  String _currentRoom;
  String _currentBorrow;
  String _currentBorrowed;
  String _currentName;
  String _currentStudentId;

  popSuccess(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Done!'),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    //for the dB
    Daily daily=Provider.of<Daily>(context);
    return StreamBuilder<DailyData>(
      stream: PracticeService(uid:daily.uid).dailyData,
      builder: (context,snapshot){
        DailyData dailyData = snapshot.data;

        return Scaffold(
        appBar: AppBar(
          title: Text('Practice'),
        ),
        body: Padding(
          padding:const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                FormBuilder(
                key: _dailyKey,
                //autovalidate: true,
                readOnly: false,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                      validator: (val)=>val.isEmpty?'Enter your name':null,
                      onChanged: (val){
                        setState(()=>_currentName=val);
                      },
                    ),

                    SizedBox(height:20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Student ID'),
                      validator: (val)=>val.isEmpty?'Enter your ID':null,
                      onChanged: (val){
                        setState(()=>_currentStudentId=val);
                      },
                    ),

                    SizedBox(height: 15.0),
                    FormBuilderDropdown(
                      attribute: 'room',
                      decoration: const InputDecoration(
                        labelText: 'Room',
                      ),
                      hint: Text('Select Room'),
                      validators: [FormBuilderValidators.required()],
                      items: room
                          .map((room) =>
                          DropdownMenuItem(
                            value: room,
                            child: Text('$room'),
                          ))
                          .toList(),
                      onChanged: (val)=>setState(()=>_currentRoom=val),
                      allowClear: true,
                    ),

                    SizedBox(height: 15.0),
                    FormBuilderDropdown(
                      attribute: 'time',
                      decoration: const InputDecoration(
                        labelText: 'Time',
                      ),
                    hint: Text('Select Time'),
                    validators: [FormBuilderValidators.required()],
                    items: time
                        .map((time) =>
                        DropdownMenuItem(
                          value: time,
                          child: Text('$time'),
                        ))
                        .toList(),
                      onChanged: (val)=>setState(()=>_currentTime=val),
                      allowClear: true,
                    ),

                  SizedBox(height: 15.0),
                  FormBuilderDropdown(
                    attribute: 'borrow',
                    decoration: const InputDecoration(
                     labelText: 'Instrument Signed Out?',
                    ),
                    hint: Text('Yes or No'),
                    validators: [FormBuilderValidators.required()],
                    items: borrow
                        .map((borrow) =>
                        DropdownMenuItem(
                          value: borrow,
                          child: Text('$borrow'),
                        ))
                        .toList(),
                    onChanged: (val)=>setState(()=>_currentBorrow=val),
                    allowClear: true,
                  ),

                  SizedBox(height: 15.0),
                  FormBuilderDropdown(
                    attribute: 'borrowed',
                    decoration: const InputDecoration(
                      labelText: 'Instrument Signed In?',
                    ),
                    hint: Text('Yes or No'),
                    validators: [FormBuilderValidators.required()],
                    items: borrowed
                        .map((borrowed) =>
                        DropdownMenuItem(
                          value: borrowed,
                          child: Text('$borrowed'),
                        ))
                        .toList(),
                    onChanged: (val)=>setState(()=>_currentBorrowed=val),
                    allowClear: true,
                  ),
                 ],
              ),
             ),

            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                  color: Colors.purpleAccent,
                    child: Text(
                      'Submit',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                    onPressed: ()async{
                      if(_dailyKey.currentState.validate()){
                        await PracticeService(uid:daily.uid).updateDailyData(
                          _currentTime?? snapshot.data.time,
                          _currentRoom?? snapshot.data.room,
                          _currentBorrow?? snapshot.data.borrow,
                          _currentBorrowed?? snapshot.data.borrowed,
                          _currentName?? snapshot.data.name,
                          _currentStudentId?? snapshot.data.studentId
                      );
                    //this closes the sheet after updating
                    Navigator.pop(context);
                    }
                      popSuccess(context);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
