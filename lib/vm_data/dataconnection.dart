import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dataconnection {
  var data;
  Future<Database> get database async {
    if (data == null) {
      data = await opendatabase();
    }
    return data;
  }

  Future<Database> opendatabase() async {
    var version = 1;
    var newdata;
    var documentsDirectory = await getDatabasesPath();
    newdata = openDatabase(join(await documentsDirectory, 'friendsapp.db'),
        version: 1, onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
        'CREATE TABLE login(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
      );
      await db.execute(
        'CREATE TABLE friendslist(id INTEGER PRIMARY KEY, name TEXT)',
      );
      await db.execute(
          'INSERT INTO friendslist(id, name)  VALUES("1234","aniket")');
    }, onOpen: (db) {
      print("db is on $db");
    });
    return newdata;
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    //version: '1',
  }
}
