import 'package:flutter/material.dart';
import 'package:friends_app/screens/adduser.dart';
import 'package:friends_app/screens/friendlistpage.dart';
import 'package:friends_app/vm_data/dataconnection.dart';
import 'package:friends_app/vm_data/vm_login.dart';

class login_page extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<login_page> createState() => login_pageState();
}

class login_pageState extends State<login_page> {
  int _counter = 0;
  dataconnection datacon = dataconnection();
  var usernamecontroller = TextEditingController();
  var passcontroller = TextEditingController();
  vm_login login = vm_login();
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
    datacon.opendatabase();
    setState(() {});
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
                    'Login',
                  ),
                ),
                // Text(
                //   '$_counter',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
                SizedBox(height: 14),
                TextField(
                  controller: usernamecontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text("Enter UserName"),
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
                  controller: passcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    label: Text("Enter Password"),
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
                          var log = await login.userlogin(
                              usernamecontroller.text,
                              passcontroller.text,
                              context);

                          if (log != null) {
                            print(log);
                            if (log == 'success') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => friendlistpage()));
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
                                      builder: (context) => login_page()));
                            });
                          }
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => adduser()));
                        },
                        child: Text(
                          "create account",
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
