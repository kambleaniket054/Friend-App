import 'package:flutter/material.dart';
import 'package:friends_app/screens/friendlistpage.dart';
import 'package:friends_app/vm_data/dataconnection.dart';
import 'package:friends_app/vm_data/vm_friendlist.dart';
import 'package:friends_app/vm_data/vm_login.dart';

class addfriend extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;
  var action;
  var fname;
  var lname;
  var number;
  addfriend({this.action, this.fname, this.lname, this.number});

  @override
  State<addfriend> createState() => addfriendState();
}

class addfriendState extends State<addfriend> {
  int _counter = 0;
  var action = '';
  dataconnection datacon = dataconnection();
  var usernamecontroller = TextEditingController();
  var passcontroller = TextEditingController();
  vm_friendlist fl = vm_friendlist();
  var fnamecontroller = TextEditingController();
  var lncontroller = TextEditingController();
  var numbercontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  void initState() {
    if (widget.action != null) {
      action = widget.action;
      if (action == 'edit') {
        fnamecontroller.text = widget.fname;
        lncontroller.text = widget.lname;
        numbercontroller.text = widget.number;
        int num = int.parse(numbercontroller.text);
      }
    }
    //  datacon.opendatabase();
    setState(() {});
  }

  @override
  void dispose() {
    fl.fetchfl();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(""),
          ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Friend Details',
                  ),
                ),
                // Text(
                //   '$_counter',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
                SizedBox(height: 14),

                // SizedBox(height: 14),
                TextField(
                  controller: fnamecontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text("Frist Name"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      gapPadding: 4.0,
                    ),
                  ),
                ),

                SizedBox(height: 14),
                TextField(
                  controller: lncontroller,
                  keyboardType: TextInputType.text,
                  // obscureText: true,
                  //obscuringCharacter: "*",
                  decoration: InputDecoration(
                    label: Text("Last Name"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      gapPadding: 4.0,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                TextField(
                  controller: numbercontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Number"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      gapPadding: 4.0,
                    ),
                  ),
                ),

                SizedBox(height: 14),
                TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  // obscureText: true,
                  // obscuringCharacter: "*",
                  decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      gapPadding: 4.0,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextButton(
                        onPressed: () async {
                          var log;
                          if (action == "edit") {
                            log = await fl.updatefriend(
                                fnamecontroller.text + " " + lncontroller.text,
                                int.parse(numbercontroller.text),
                                int.parse(numbercontroller.text));
                          } else {
                            log = await fl.addfriend(
                                fnamecontroller.text + " " + lncontroller.text,
                                int.parse(numbercontroller.text));
                          }

                          if (log != null) {
                            print(log);
                            if (log == 'sucess') {
                              fl.datastream.add(true);
                              Navigator.pop(context);
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(24),
                                              topRight: Radius.circular(24)),
                                        ),
                                        child:
                                            Text("invalid Username Password"),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24)),
                                      ),
                                      child: Text("username does not exisist"),
                                    ),
                                  );
                                }).whenComplete(() {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => friendlistpage()));
                            });
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
