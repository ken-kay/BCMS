
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:bcms_app/screens/home/home.dart';
//for pullout menu
import 'package:bcms_app/models/side.dart';

class Track extends StatefulWidget {
  final FirebaseUser user;
  Track({Key key,this.user});
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track>
    with SingleTickerProviderStateMixin{
  FirebaseUser user;
  final _cloudFirestore=Firestore.instance.collection('practice').snapshots();
  GlobalKey<FormState>_formChain=GlobalKey<FormState>();
  TextEditingController _textController=TextEditingController();
  final uid=Firestore.instance.collection('students').document().documentID;
  bool active=true;

  var now=DateTime.now();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 6.0,
        backgroundColor: Colors.pink,
        leading: Padding(
          padding: const EdgeInsets.all(11.0),
          child: GestureDetector(
            onTap: () {
              print("Tapped");
            },
            child: Image.asset(
              'assets/app-bg.png',
              height: 100.0,
              width: 100.0,
            ),
          ),
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Practice Practice Practice",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
              ),
            ),

          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: _cloudFirestore,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Container(
                  child: Dismissible(
                    resizeDuration: Duration(milliseconds: 1000),
                    secondaryBackground: Card(
                      elevation: 6.0,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(18.0),
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.red,
                          icon: Icon(Icons.delete_outline),
                        ),
                      ),
                    ),
                    background: Card(
                      elevation: 6.0,
                      child: Container(
                        padding: EdgeInsets.all(18.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: 20.0
                          ),

                        ),
                      ),
                    ),

                    key: Key(Firestore.instance
                        .collection('students')
                        .document()
                        .documentID
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)
                        ),
                        elevation: 6.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: ListTile(
                                onTap: () {
                                  print("List tile pressed");
                                  print(Firestore.instance
                                      .collection('practice')
                                      .document());
                                },
                                leading: CircleAvatar(
                                  child: Text(
                                    ds['practice'][0].toString().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                                title: Text(
                                  ds['practice'].toString(),
                                  style: TextStyle(),
                                ),

                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Created on $now"),
                                ),

                                trailing: IconButton(
                                  color: Colors.red,
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    print("${ds['practice']} is deleted");
                                    Firestore.instance
                                        .collection('practice')
                                        .document(ds.documentID)
                                        .delete();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    onDismissed: (direction) {
                      print("${ds['practice']} is deleted");
                      Firestore.instance
                          .collection('practice')
                          .document(ds.documentID)
                          .delete();
                    },
                  ),
                );
              },
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 9.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          _showFormDialog();
        },
        tooltip: "Record Practice",
      ),
      drawer: Side(),
    );
  }

  _showFormDialog(){
    var alert=AlertDialog(
      content: Row(
        children: <Widget>[
          Form(
            key: _formChain,
            child: Expanded(
              child: ListTile(
                title: TextFormField(
                  controller: _textController,
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Please enter practice';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Practice',
                    labelText: 'Practice Hour',
                    icon: Icon(Icons.note_add),
                  ),
                  autofocus: true,
                ),
              ),
            ),
          ),
        ],
      ),
      actions:<Widget> [
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: (){
            if(_formChain.currentState.validate()) {
              _handleSubmit();
              _textController.clear();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (_)=>alert,
        barrierDismissible: false
    );
  }

  void _handleSubmit() {
    if (Firestore.instance.collection('practice').document() == null) {
      Firestore.instance.collection('practice').document().setData({'practice': ''});
    } else {
      Firestore.instance
          .collection('practice')
          .document()
          .setData({'practice': _textController.text.toString()});
      debugPrint('Practice Hour added');
    }
  }
}



/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'package:bcms_app/screens/practice/log.dart';
import 'package:bcms_app/models/side.dart';
import 'package:bcms_app/screens/practice/practice.dart';

class Track extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Practice Practice Practice'),
        ),
        body: Center(
          child: Column(
            children:<Widget> [
              Container(

              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Practice Session'),
          icon: Icon(Icons.event_note),
          backgroundColor: Colors.green,
          onPressed: (){
            Navigator.push(
            context,
          MaterialPageRoute(
            builder: (context)=>Practice()),
            );
          },
        ),

        drawer: Side(),
      ),
    );
  }
}


 */