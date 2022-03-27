import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friends_app/screens/friendlistpage.dart';
import 'package:friends_app/screens/login_page.dart';
import 'package:friends_app/vm_data/dataconnection.dart';

class vm_login {
  dataconnection datab = dataconnection();

  userlogin(String username, String password, BuildContext context) async {
    var db = await datab.database;
    var log =
        await db.rawQuery("SELECT * FROM login WHERE username = '$username'");
    if (log.isNotEmpty == true) {
      print(log);
      if (log.first.containsValue(password)) {
        return "success";
      } else {
        return "failure";
      }
    } else {
      return;
    }
  }

  createuser(String username, String password, context) async {
    var db = await datab.database;
    var log = await db.rawInsert(
        'INSERT INTO login(id, username, password)  VALUES("1234","$username","$password")');
    if (log != null) {
      return "success";
    }
  }
}
