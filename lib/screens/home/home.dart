import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/models/side.dart';
import 'package:bcms_app/models/music.dart';
import 'package:bcms_app/services/auth.dart';
import 'package:bcms_app/services/database.dart';
import 'package:bcms_app/screens/music/music_list.dart';
//import 'package:bcms_app/screens/home/wrapper.dart';
//import 'package:bcms_app/screens/music/settings_form.dart';
//moved this one to home
import 'package:bcms_app/screens/music/choose.dart';
import 'package:bcms_app/screens/practice/practice.dart';
//For the other pages, old iteration:
//import 'package:bcms_app/screens/schedule/calendar.dart';
//import 'package:bcms_app/screens/work/homework.dart';
//import 'package:bcms_app/screens/sheets/pieces.dart';
//import 'package:bcms_app/screens/record/record.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  //to change the text on the floating button
  //bool check = true;
  @override
  Widget build(BuildContext context) {
    //void _showSettingsPanel()
    /*
     {
      showModalBottomSheet(
          context: context,
          builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
          ),
          child: Practice(),
        );
      });
    }

     */

    return StreamProvider<List<Music>>.value(
      value:DatabaseService().musics,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('BCMS'),
          backgroundColor:Colors.black,
          elevation:0.0,
          actions: <Widget>[
            /*
            FlatButton.icon(
              icon: Icon(Icons.music_note),
              color: Colors.grey,
              label: Text('Register'),
              onPressed: () => _showSettingsPanel(),
            ),
             */
            FlatButton.icon(
              icon:Icon(Icons.person),
              color: Colors.white,
              label: Text('Sign Out'),
              onPressed:() async{
                  await _auth.signOut();
              },
            ),
          ],
        ),

        //For registration
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Register'),
          icon: Icon(Icons.music_note),
          backgroundColor: Colors.purple,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>ChooseForm()),
            );
          },

          //Didn't want this on top
          /*
          label: Text('Register'),
          icon: Icon(Icons.music_note),
          backgroundColor: Colors.purple,
          */
        ),

        //tried to fix the error I was getting before, canceling the redundancy
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waiting.png'),
                fit: BoxFit.cover,
              ),
            ),
            //child: MusicList()
        ),
        drawer: Side(),
      ),
    );
  }
}

/*decoration: BoxDecoration(
            gradient: LinearGradient(colors:
              [Colors.indigo, Colors.lightBlueAccent]
            ),
          ),
           */
          /*
          child: Scaffold(
            appBar: AppBar(

              title: Text('BCMS Mobile App'),
            ),

           */

            //For registration
            /*
            floatingActionButton: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>Choose()),
                );
              },
              label: Text('Register'),
              icon: Icon(Icons.music_note),
              backgroundColor: Colors.purple,
            ),

             */




            /*
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    const[

                      ListTile(
                        trailing: Icon(Icons.flare),
                          title:Text('Announcements:')),
                    ]
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pinkAccent,
                          Colors.indigo]
                      )
                    ),
                    //color: Colors.lightBlueAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const[
                        //I'll change the logo down the line
                        FlutterLogo(size:200),
                        Text('BCMS',
                        textAlign: TextAlign.center,
                          textScaleFactor: 6,
                        ),
                      ],
                    ),

                  ),

                )
              ],

            ),
            */

            /*body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors:
                [Colors.indigo, Colors.lightBlueAccent]
                ),
              ),
            ),
             */

            //backgroundColor: Colors.black54,

                //Made this for navigation


          //This is the original way I displayed the homepage, need to change this up:
          /*

          body: Container(
            //body: Scaffold(
            //still trying to fix this
            // the original:
            child: Column(
            //Flexible(child:Column(

              children: <Widget>[

                //trying to fix the error
                //Flexible(child: ListTile()),

                ListTile(


                  leading: Icon(Icons.power_settings_new),
                  title: Text('Welcome to the BCMS Mobile App'),
                  subtitle: Text('Make a selection below'),
                //contentPadding: EdgeInsets.symmetric(),                  onTap: ()=>{}
                ),

                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Text('Homework'),
                  onPressed: () {
                    //go to Assignments page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //Change back if it doesn't work
                        builder: (context) => Homework()),
                          //builder: (context) => HomeworkApp()),
                    );
                  },
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Text('Schedule'),
                  onPressed: (){
                    //go to Schedule page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>Calendar()),
                    );
                  },
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Text('Pieces'),
                  onPressed: (){
                    //go to Sheets page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>Pieces()),
                    );
                  },
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Text('Record'),
                  onPressed: (){
                    //go to Record page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>Record()),
                    );
                  },
                ),
              ],
            ),
          ),




        //Made this for navigation
        drawer: Side(),
      ),
    );
  }

           */
          //The rest is packaged
          //);
