import 'package:flutter/material.dart';
import 'package:bcms_app/admin/admin_side.dart';
import 'package:bcms_app/admin/admin_home.dart';

class Move extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      ),
      floatingActionButton: FloatingActionButton.extended(
      label: Text('Admin'),
        icon: Icon(Icons.forward),
        backgroundColor: Colors.amber,
        onPressed: (){
        AdminHome();
        },
      ),
      drawer: AdminSide(),
    );
  }
}
