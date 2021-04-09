import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//for pullout menu
import 'package:bcms_app/models/side.dart';


class Homework extends StatefulWidget {
  final FirebaseUser user;
  Homework({Key key,this.user});
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework>
  with SingleTickerProviderStateMixin{
  FirebaseUser user;
  final _cloudFirestore=Firestore.instance.collection('tasks').snapshots();
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
        titleSpacing: 10.0,
        backgroundColor: Colors.indigo,
        leading: Padding(
          padding: const EdgeInsets.all(11.0),
          child: GestureDetector(
            onTap: () {
              print("Tapped");
            },
           /*
            child: Image.asset(
              'assets/logo.png',
              height: 100.0,
              width: 100.0,
            ),
            */
          ),
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Homework",
              style: TextStyle(
                  //color: Colors.black,
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
                                      .collection('tasks')
                                      .document());
                                },
                                leading: CircleAvatar(
                                  child: Text(
                                    ds['task'][0].toString().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                                title: Text(
                                  ds['task'].toString(),
                                  style: TextStyle(),
                                ),

                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Created on $now"),
                                ),

                                trailing: IconButton(
                                  color: Colors.black,
                                  icon: Icon(Icons.delete, size: 30.0,),
                                  onPressed: () {
                                    print("${ds['task']} is deleted");
                                    Firestore.instance
                                        .collection('tasks')
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
                      print("${ds['task']} is deleted");
                      Firestore.instance
                          .collection('tasks')
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
        backgroundColor: Colors.green,
        onPressed: () {
          _showFormDialog();
        },
        tooltip: "Add Work",
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
                  //remove warning
                  // ignore: missing_return
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Please enter work';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Homework',
                    labelText: 'To Do',
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
    if (Firestore.instance.collection('tasks').document() == null) {
      Firestore.instance.collection('tasks').document().setData({'task': ''});
    } else {
      Firestore.instance
          .collection('tasks')
          .document()
          .setData({'task': _textController.text.toString()});
      debugPrint('Work added');
    }
  }
}
