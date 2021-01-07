import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:intl/intl.dart';

import 'package:bcms_app/shared/constants.dart';
import 'package:bcms_app/models/user.dart';
import 'package:bcms_app/services/database.dart';
//if the thing works then I'll consider having a loading feature
//import 'package:bcms_app/shared/loading.dart';
//changed the styling
//import 'package:bcms_app/shared/constants.dart';


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

  //var instruments = ['Violin', 'Piano', 'Guitar'];

  //final _ageController = TextEditingController(text: '45');
  //bool _ageHasError = false;

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
                    // context,
                    key: _formKey,
                    //key: _fbKey,
                    autovalidate: true,

                    /*
                    initialValue: {
                      'instrument': 'Piano',
                      'level': 'Beginner',
                      'hour': '12:00',
                      //'filter_chip': ['Test', 'Test 1'],
                      //'date': DateTime.now(),
                    },
                    */
                    readOnly: false,
                    child: Column(
                      children: <Widget>[
                        /*
                  SizedBox(height: 15),
                  FormBuilderDateTimePicker(
                    attribute: 'date',
                    onChanged: _onChanged,
                    inputType: InputType.both,
                    decoration: const InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    validator: (val) => null,
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    // initialValue: DateTime.now(),
                    // readonly: true,
                  ),

                   */


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
                          // isExpanded: false,
                          allowClear: true,
                        ),

                        SizedBox(height: 15),
                        FormBuilderDropdown(
                          attribute: 'level',
                          decoration: const InputDecoration(
                            labelText: 'Experience',
                          ),
                          // initialValue: 'Male',
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
                          // isExpanded: false,
                          allowClear: true,
                        ),

                        SizedBox(height: 15),
                        FormBuilderDropdown(
                          attribute: 'hour',
                          decoration: const InputDecoration(
                            labelText: 'Time',
                          ),
                          // initialValue: 'Male',
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
                          // isExpanded: false,
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
                            ///*
                            if(_formKey.currentState.validate()){

                             //*/
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

/*
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}
//attempting a different type of form:
//class _SettingsFormState extends State<SettingsForm> {

//}

SizedBox(height: 15),
                  FormBuilderDropdown(
                    attribute: 'gender',
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                    // initialValue: 'Male',
                    hint: Text('Select Gender'),
                    validators: [FormBuilderValidators.required()],
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            ))
                        .toList(),
                    // isExpanded: false,
                    allowClear: true,
                  ),

                  //for the extension
 Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                      } else {
                        print(_fbKey.currentState.value);
                        print('validation failed');
                      }
                    },
                  ),
                ),
 */






/*
class _SettingsFormState extends State<SettingsForm> {

  final _formKey=GlobalKey<FormState>();
  final List<String> hours = [
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
  final List<String> instruments=[
    'Violin',
    'Piano',
    'Guitar',
  ];
  final List<String> levels= [
    'Beginner',
    'Novice',
    'Experienced',
  ];
/*
  //try to set the Date and Time
  SizedBox(height:10.0),
  FormBuilderDateTimePicker(
      attribute: 'date',
  onChanged: _onChanged,
  inputType:InputType.both,
  decoration: const InputDecoration(
      labelText:'Class Time',
      ),
  validator: (val)=>null,
  initialTime:TimeOfDay(
      hour:8,
      minute:0
      ),
      ),

 */



  //keep track of form values
  String _currentInstruments;
  String _currentLevels;
  String _currentHours;


  @override
  Widget build(BuildContext context) {
    User user=Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context,snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Select Your Instrument',
                  style:TextStyle(fontSize: 18.0),
                ),

                /*
                SizedBox(height: 20.0),

                TextFormField(
                  initialValue: userData.level,
                    decoration: textInputDecoration,
                    validator: (val)=>val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val)=>setState(()=>_currentLevel=val)
                ),
                 */

                SizedBox(height: 10.0),
                //select instrument
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentInstruments ?? userData.instruments,
                  items: instruments.map((instrument){
                    return DropdownMenuItem(
                      value:instrument,
                      child: Text('$instrument selected'),
                    );
                  }).toList(),
                  onChanged: (val)=>setState(()=>_currentInstruments=val),
                ),


                SizedBox(height: 10.0),
                //select level
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentLevels ?? userData.levels,
                  items: levels.map((level){
                    return DropdownMenuItem(
                      value:level,
                      child: Text('$level Ability'),
                    );
                  }).toList(),
                  onChanged: (val)=>setState(()=>_currentLevels=val),
                ),


                SizedBox(height: 10.0),
                //select time
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentHours ?? userData.hours,
                  items: hours.map((hour){
                    return DropdownMenuItem(
                      value:hour,
                      child: Text('$hour hours'),
                    );
                  }).toList(),
                  onChanged: (val)=>setState(()=>_currentHours=val),
                ),


                RaisedButton(
                  color: Colors.lightBlue,
                  child: Text(
                    'Update',
                    style:TextStyle(color:Colors.black),
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid:user.uid).updateUserData(
                          _currentInstruments?? snapshot.data.instruments,
                          _currentLevels?? snapshot.data.levels,
                          _currentHours?? snapshot.data.hours,
                      );
                      //this closes the sheet after updating
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}


 */







/*
//this one didn't work
import 'package:bcms_app/screens/home/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/models/music.dart';
import 'music_list.dart';
import 'package:bcms_app/screens/music/settings_form.dart';
import 'package:bcms_app/services/database.dart';
//doesn't seem like I need this now:
import 'package:bcms_app/services/auth.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';

class Choose extends StatelessWidget {
  //final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0
          ),
          child: SettingsForm(),
        );
       }
      );
    }


    return StreamProvider<List<Music>>.value(
      value: DatabaseService().musics,
      child: Scaffold(
        backgroundColor:
        Colors.grey,
        appBar: AppBar(
          title: Text('Pick Classes'),
          backgroundColor: Colors.green,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.music_note),
              label: Text('Register'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),

        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waiting.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: MusicList()
        ),
        drawer: Side(),
      ),
    );
  }
}

 */