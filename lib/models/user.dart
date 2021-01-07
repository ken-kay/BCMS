class User{
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String levels;
  final String instruments;
  final String hours;
  //Enter their name and Student ID
  final String name;
  final String studentId;

  UserData({
    this.uid,
    this.levels,
    this.instruments,
    this.hours,
    //Enter their name and Student ID
    this.name,
    this.studentId,
  });
}