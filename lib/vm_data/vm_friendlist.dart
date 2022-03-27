import 'dart:async';

import 'dataconnection.dart';

class vm_friendlist {
  var fl;
  var db = dataconnection();
  var datastream = StreamController<bool>.broadcast();
  fetchfl() async {
    fl = [];
    var data = await db.database;
    var log = await data.rawQuery("SELECT * FROM friendslist");
    print(log);
    if (log.isNotEmpty == true) {
      for (int i = 0; i < log.length; i++) {
        fl.add(
            '${log.elementAt(i).values.elementAt(0)}|${log.elementAt(i).values.elementAt(1)}');
      }
      print(fl);

      print('sucess');
      datastream.add(true);
      return 'sucess';
    } else {
      return 'failure';
    }
  }

  addfriend(String name, int number) async {
    var data = await db.database;
    print(data);
    var log = await data
        .rawQuery("INSERT INTO friendslist VALUES('$number','$name')");
    print(log);
    datastream.add(true);
    return 'sucess';
    // if (log.isNotEmpty == true) {
    //   return 'sucess';
    // } else {
    //   return 'failure';
    // }
  }

  updatefriend(String name, int number, int number1) async {
    var data = await db.database;
    print(data);
    var log = await data.rawQuery(
        "UPDATE friendslist SET id='$number',name='$name' WHERE id ='$number1' ");
    print(log);
    datastream.add(true);
    return 'sucess';
    // if (log.isNotEmpty == true) {
    //   return 'sucess';
    // } else {
    //   return 'failure';
    // }
  }

  deletefriend(int number) async {
    var data = await db.database;
    print(data);
    var log =
        await data.rawQuery("DELETE FROM friendslist WHERE id ='$number' ");
    print(log);
    datastream.add(true);
    return 'sucess';
    // if (log.isNotEmpty == true) {
    //   return 'sucess';
    // } else {
    //   return 'failure';
    // }
  }
}
