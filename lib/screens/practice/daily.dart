class Daily{
  final String uid;
  Daily({this.uid});
}


class DailyData{
  final String uid;
  final String time;
  final String room;
  final String borrow;
  final String borrowed;
  //Enter their name and Student ID
  final String name;
  final String studentId;

  DailyData({
    this.uid,
    this.time,
    this.room,
    this.borrow,
    this.borrowed,
    //Adding to test
    this.name,
    this.studentId,
  });
}