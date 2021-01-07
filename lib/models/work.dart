//import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

//This is a model for the tasks assigned by teachers
//The student can add them after every lesson

/*
//This is the Work class from before
class Work{
  final String id;
  String description;
  DateTime dueDate;
  TimeOfDay userTime;
  bool isDone;

  Work({
   @required this.id,
   @required this.description,
   this.dueDate,
    this.userTime,
   this.isDone=false,
});
}

class WorkProvider with ChangeNotifier{
  List<Work>get itemsList{
    return _toDoList;
  }
  final List<Work> _toDoList =[
    Work(
      id: 'screens.work#1',
      description: 'Started Classes',
      dueDate: DateTime.now(),
      userTime: TimeOfDay.now(),
    ),
  ];
  Work getById(String id){
    return _toDoList.firstWhere((work)=>work.id==id);
  }
  void createNewWork(Work work){
    final newWork=Work(
      id:work.id,
      description: work.description,
      dueDate: work.dueDate,
      userTime: TimeOfDay.now(),
    );
    _toDoList.add(newWork);
    notifyListeners();
  }
  void editWork(Work work){
    removeWork(work.id);
    createNewWork(work);
  }
  void removeWork(String id){
    _toDoList.removeWhere((work)=>work.id==id);
    notifyListeners();
  }
  void changeStatus(String id){
    int index = _toDoList.indexWhere((work)=>work.id==id);
    _toDoList[index].isDone=!_toDoList[index].isDone;
    //this is to show if they've been completed
  }
}

 */

class Work {
  int _id;
  String _work, _date, _time, _status;

  Work(this._work, this._date, this._time, this._status);

  Work.withId(this._id, this._work, this._date, this._time, this._status);

  int get id => _id;

  String get work => _work;

  String get date => _date;

  String get time => _time;

  String get status => _status;

  set work(String newWork) {
    if (newWork.length <= 255) {
      this._work = newWork;
    }
  }

  set date(String newDate) => this._date = newDate;

  set time(String newTime) => this._time = newTime;

  set status(String newStatus) => this._status = newStatus;

  //Convert Work object into MAP object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['work'] = _work;
    map['date'] = _date;
    map['time'] = _time;
    map['status'] = _status;
    return map;
  }

//Extract Task object from MAP object
  Work.fromMapObject(Map<String, dynamic>map)
  {
  this._id=map['id'];
  this._work=map['work'];
  this._date=map['date'];
  this._time=map['time'];
  this._status=map['status'];
  }
}