import 'dart:async';
import 'dart:io';
//import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Details{
  int dateId;
  bool h1=false,
  h2=false,
  h3=false,
  h4=false,
  h5=false,
  h6=false;

  int total=0,
  working=6;

  DB db=DB();

  Details(DateTime date){
    var x=date.year.toString();
    if(date.month<10)x=x+'0';
    x=x+date.month.toString();
    if(date.day<10)x=x+'0';
    x=x+date.day.toString();
    dateId=int.parse(x);
  }

  Map<String,dynamic>toMap(){
    var map=Map<String,dynamic>();
    map['dateId']=dateId;
    map['h1']=h1;
    map['h2']=h2;
    map['h3']=h3;
    map['h4']=h4;
    map['h5']=h5;
    map['h6']=h6;
    map['total']=total;
    map['working']=working;
    return map;
  }

  Details.fromMap(Map<String,dynamic>map){
    dateId=map['dateId'];
    h1=map['h1']!=0;
    h2=map['h2']!=0;
    h3=map['h3']!=0;
    h4=map['h4']!=0;
    h5=map['h5']!=0;
    h6=map['h6']!=0;
    total=map['total'];
    working=map['working'];
  }

  update()async{
    db.update(this);
    print("day=${this.total}/${this.working}");
  }

  refresh()async{
    var date=DateTime(int.parse(
      dateId.toString()[0] + dateId.toString()[1] + dateId.toString()[2] + dateId.toString()[3]),
    int.parse(dateId.toString()[4] + dateId.toString()[5]),
    int.parse(dateId.toString()[6] + dateId.toString()[7]));
    if(date.weekday==7)date=date.add(
      Duration(days: -2));
    else if(date.weekday==6)date=date.add(
      Duration(days: -1));

    dateId=(date.year * 100 + date.month) * 100 + date.day;
    print(dateId);

    var x=await db.fetch(this.dateId);
    if(x==null)db.add(this);

    else{
      this.h1=x.h1;
      this.h2=x.h2;
      this.h3=x.h3;
      this.h4=x.h4;
      this.h5=x.h5;
      this.h6=x.h6;
      this.total=x.total;
      this.working=x.working;
    }
  }

  remove()async{
    db.remove(dateId);
  }
}


class Stats{
  int total=0,
  working=0;
  DB db=DB();

  Stats(
      this.total,
      this.working);

  Stats.fromDB(Map<String,dynamic>map){
    total=map['total'];
    working=map['working'];
  }

  update()async{
    var result=await db.getStats();
    if(result !=null&&result.working!=null){
      this.total=result.total;
      this.working=result.working;
    }
    print("total=${this.total}/${this.working}");
  }
}

class DB{
  static final DB _instance=DB._();
  static Database _database;
  DB._();
  factory DB()=>_instance;

  Future<Database>get db async{
    if(_database!=null)return _database;
    _database=await init();
    return _database;
  }

  Future<Database>init()async{
    Directory directory=await getApplicationDocumentsDirectory();
    String dbPath=join(directory.path, 'database.db');

    var database=openDatabase(
      dbPath,
      version:1,

      onCreate: (
      Database db,
          int version){
        db.execute('''
        CREATE TABLE details(
        dateId INT PRIMARY KEY,
        h1 BOOLEAN,
        h2 BOOLEAN,
        h3 BOOLEAN,
        h4 BOOLEAN,
        h5 BOOLEAN,
        h6 BOOLEAN,
        total INTEGER NOT NULL DEFAULT 0,
        working INTEGER NOT NULL DEFAULT 0
        )
        ''');
        print("Database was created!");
      },
      onUpgrade: (
      Database db,
          int oldVersion,
          int newVersion)
      {
        /*Run the migration from old to new*/
      },
    );
    return database;
  }

  //CRUD

Future<int>add(Details day)async{
    var pupil=await db;
    return pupil.insert('details',day.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<Details>fetch(int dateId)async{
    var pupil=await db;
    final Future<List<Map<String,dynamic>>> futureMaps=pupil.query(
      'details',
      where:'dateId=?',
      whereArgs:[dateId]);

    var maps=await futureMaps;
    if(maps.length!=0)return Details.fromMap(maps.first);
    return null;
}

Future<int>update(Details newDay)async{
    var pupil=await db;
    return pupil.update(
      'details',
      newDay.toMap(),
      where: 'dateId=?',
      whereArgs: [newDay.dateId],
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Details>>fetchAll()async{
    var pupil=await db;
    var result=await pupil.rawQuery('SELECT * FROM details');
    if(result.length==0)return null;
    List<Details>list=result.map((item)=>Details.fromMap(item)).toList();
    return list;
}

Future<void>remove(int dateId)async{
    var pupil=await db;
    return pupil.delete(
      'details',
      where:'dateId=?',
      whereArgs:[dateId]);
}

//Stats

Future<Stats>getStats()async{
    var pupil=await db;
    final Future<List<Map<String, dynamic>>> futureStats=pupil.rawQuery(
      "SELECT SUM(total) as total,SUM(working) as working FROM details");
    var stats=await futureStats;
    if(stats.length!=0)return Stats.fromDB(stats.first);
    else return getStats();
}

Future<void>clearStats()async{
    var pupil=await db;
    return pupil.rawQuery("TRUNCATE details");
}

}




