import 'package:flutter/material.dart';

import 'package:bcms_app/services/records_db.dart';
import 'package:bcms_app/models/teacher.dart';
//pullout menu
import 'package:bcms_app/models/side.dart';

class Teaching extends StatefulWidget {
  @override
  _TeachingState createState() => _TeachingState();
}

class _TeachingState extends State<Teaching> {
  DB db=DB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        minimum: EdgeInsets.only(
          top:40.0),
        child: FutureBuilder<List<Details>>(
          future: db.fetchAll(),
          builder: (context,snapshot){
            if(!snapshot.hasData)
              return Center(
                child: Text(
                  'No records',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w500)));

            return ListView(
              children:snapshot.data.map((day){
                var x=day.dateId.toString();
                print(x);
                var date='${x[6]}${x[7]} - ${x[4]}${x[5]} - ${x[2]}${x[3]}';
                var boxColor=Colors.white;
                if(day.total/day.working<4/6){
                  boxColor=Colors.red[50];
                  if(day.total/day.working<2/6){
                    boxColor=Colors.red[100];
                    if(day.total==0)boxColor=Colors.red[200];
                  }
                }
                if(day.total/day.working==1) boxColor=Colors.green[100];

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 10.0),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: boxColor,
                        borderRadius: BorderRadius.circular(4.0)),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget> [
                          Container(
                            child: Text(
                              date,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0),
                            ),
                          ),

                          Container(
                            child: Text(
                              '${day.total}/${day.working}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),

                    onPanUpdate: (move){
                      if(move.delta.dx!=0){
                        print('swiped');
                        showDialog(
                            context: context,
                        builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Trash?'),
                                content: Text('Are you sure?'),
                                actions:<Widget> [
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    }
                                  ),
                                  FlatButton(
                                    child: Text('Trash.'),
                                    onPressed: (){
                                      setState(() {
                                        day.remove();
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  )
                                ],
                              );
                            }
                        );
                      }
                    },
                  ),
                );
              }).toList(),
            );
          },
        )
      ),
     drawer: Side(),
    );
  }
}
