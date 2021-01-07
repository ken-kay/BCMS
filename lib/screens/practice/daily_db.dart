import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bcms_app/screens/practice/daily.dart';
import 'package:bcms_app/screens/practice/log.dart';

class PracticeService{

  final String uid;
  PracticeService({this.uid});
  //collection reference
  final CollectionReference logCollection = Firestore.instance.collection('logs');
//Maybe do <void> after Future if the login sys still crashes...
  Future<void> updateDailyData(
      String time,
      String room,
      String borrow,
      String borrowed,
      String name,
      String studentId,
      ) async{
    return await logCollection.document(uid).setData({
      'time':time,
      'room': room,
      'borrow':borrow,
      'borrowed':borrowed,
      'name':name,
      'studentId':studentId,
    });
  }

  //log list from snapshot
  List<Log> _logListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Log(
        time: doc.data['time'] ?? '',
        room: doc.data['room'] ?? '',
        borrow: doc.data['borrow'] ?? '',
        borrowed: doc.data['borrowed'] ?? '',
        name:doc.data['name']?? '',
        studentId:doc.data['studentId']?? '',
      );
    }).toList();
  }

  //daily from snapshot
  DailyData _dailyDataFromSnapshot(DocumentSnapshot snapshot){
      return DailyData(
        uid:uid,
        time: snapshot.data['time'] ?? '',
        room: snapshot.data['room'] ?? '',
        borrow: snapshot.data['borrow'] ?? '',
        borrowed: snapshot.data['borrowed']?? '',
        name:snapshot.data['name']?? '',
        studentId:snapshot.data['studentId']?? '',
      );

  }

  //get log stream
  Stream<List<Log>> get logs{
    return logCollection.snapshots()
        .map(_logListFromSnapshot);
  }

  //get practice stream
  Stream<DailyData> get dailyData{
    return logCollection.document(uid).snapshots()
        .map(_dailyDataFromSnapshot);
  }


}
