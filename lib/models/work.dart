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