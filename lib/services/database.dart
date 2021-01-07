import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bcms_app/models/user.dart';
import 'package:bcms_app/models/music.dart';
//import 'package:bcms_app/models/profile.dart';
//import 'package:bcms_app/screens/practice/practice_db.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference musicCollection = Firestore.instance.collection('musics');
//Maybe do <void> after Future if the login sys still crashes...
  Future<void> updateUserData(
      String instruments,
      String levels,
      String hours,
      String name,
      String studentId,
      ) async{
    return await musicCollection.document(uid).setData({
      'instruments':instruments,
      'levels': levels,
      'hours':hours,
      'name':name,
      'studentId':studentId,
    });
  }

  //instrument list from snapshot
  List<Music> _musicListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Music(
        instruments: doc.data['instruments'] ?? '',
        levels: doc.data['levels'] ?? '',
        hours: doc.data['hours'] ?? '',

        name:doc.data['name']?? '',
        studentId:doc.data['studentId']?? '',
      );
    }).toList();
  }

//userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      instruments:snapshot.data['instruments'],
      levels:snapshot.data['levels'],
      hours:snapshot.data['hours'],

      name:snapshot.data['name'],
      studentId:snapshot.data['studentId'],
    );
  }



  //get instrument stream
Stream<List<Music>> get musics{
    return musicCollection.snapshots()
        .map(_musicListFromSnapshot);
}

  //get user document stream
Stream<UserData> get userData{
    return musicCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}

