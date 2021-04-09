import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:bcms_app/shared/constants.dart';
import 'package:bcms_app/models/user.dart';
import 'package:bcms_app/services/database.dart';


class ChooseForm extends StatefulWidget {
  @override
  _ChooseFormState createState() {
    return _ChooseFormState();
  }
}

class _ChooseFormState extends State<ChooseForm> {
  //var data;
  //bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  //final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  //I think this didn't work because I'm using a FormBuilder and not a Form
  //final _formKey=GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  //final ValueChanged _onChanged = (val) => print(val);
  final List<String> instruments= [
    'Violin',
    'Piano',
    'Guitar',
  ];
  final List<String> levels=[
    'Beginner',
    'Novice',
    'Experienced',
  ];
  final List<String> hours=[
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


  //keep track of form values:
  String _currentInstruments;
  String _currentLevels;
  String _currentHours;

  String _currentName;
  String _currentStudentId;


  popSuccess(BuildContext context){
    return showDialog(
      context: context,
      builder:(context){
        return AlertDialog(
          title: Text('Successfully Registered!'),
          actions: <Widget>[
            MaterialButton(
              elevation: 4.0,
              child: Text('OK'),
              onPressed:(){
                Navigator.pop(context);
              } ,
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    //this is for using the dB
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context,snapshot) {
            UserData userData = snapshot.data;

          return Scaffold(
            //return Scaffold(
            appBar: AppBar(
              title: Text('Register'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  FormBuilder(
                    key: _formKey,
                    readOnly: false,
                    child: Column(
                      children: <Widget>[


                        SizedBox(height:20.0),
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

                        SizedBox(height: 15),
                        FormBuilderDropdown(
                          attribute: 'instrument',
                          decoration: const InputDecoration(
                            labelText: 'Instrument',
                          ),

                          hint: Text('Select Instrument'),
                          validators: [FormBuilderValidators.required()],
                          items: instruments
                              .map((instrument) =>
                              DropdownMenuItem(
                                value: instrument,
                                child: Text('$instrument'),
                              ))
                              .toList(),
                          onChanged: (val)=>setState(()=>_currentInstruments=val),
                          allowClear: true,
                        ),

                        SizedBox(height: 15),
                        FormBuilderDropdown(
                          attribute: 'level',
                          decoration: const InputDecoration(
                            labelText: 'Experience',
                          ),
                          hint: Text('Select Level'),
                          validators: [FormBuilderValidators.required()],
                          items: levels
                              .map((level) =>
                              DropdownMenuItem(
                                value: level,
                                child: Text('$level'),
                              ))
                              .toList(),
                          onChanged: (val)=>setState(()=>_currentLevels=val),
                          allowClear: true,
                        ),

                        SizedBox(height: 15),
                        FormBuilderDropdown(
                          attribute: 'hour',
                          decoration: const InputDecoration(
                            labelText: 'Time',
                          ),
                          hint: Text('Select Time'),
                          validators: [FormBuilderValidators.required()],
                          items: hours
                              .map((hour) =>
                              DropdownMenuItem(
                                value: hour,
                                child: Text('$hour'),
                              ))
                              .toList(),
                          onChanged: (val)=>setState(()=>_currentHours=val),
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
                            if(_formKey.currentState.validate()){
                              await DatabaseService(uid:user.uid).updateUserData(
                                _currentInstruments?? snapshot.data.instruments,
                                _currentLevels?? snapshot.data.levels,
                                _currentHours?? snapshot.data.hours,

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