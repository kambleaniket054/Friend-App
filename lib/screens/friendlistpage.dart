import 'package:flutter/material.dart';
import 'package:friends_app/screens/addfriend.dart';
import 'package:friends_app/vm_data/vm_friendlist.dart';

class friendlistpage extends StatefulWidget {
  // const friendlistpage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<friendlistpage> createState() => friendlistpageState();
}

class friendlistpageState extends State<friendlistpage> {
  // int _counter = 0;
  var friendlist;
  vm_friendlist vmfl = vm_friendlist();
  @override
  void initState() {
    friendlist = vmfl.fetchfl();

    vmfl.datastream.stream.listen((event) {
      friendlist = vmfl.fl;
    });
    super.initState();
  }

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
  Widget build(BuildContext context) {
    vmfl.fetchfl();
    // setState(() {
    //   friendlist = vmfl.fl;
    //   print(friendlist);
    // });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //     // Here we take the value from the MyHomePage object that was created by
      //     // the App.build method, and use it to set our appbar title.
      //     // title: Text(""),
      //     ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder<bool>(
                stream: vmfl.datastream.stream,
                builder: (context, snapshot) {
                  friendlist = vmfl.fl;
                  print("############################");
                  print(friendlist);
                  return RefreshIndicator(
                    onRefresh: () => vmfl.fetchfl(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: friendlist.length,
                        itemBuilder: (context, index) {
                          var list = friendlist[index].toString().split("|");
                          var number = list[0];
                          var name = list[1];
                          return Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: " + name.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Number: " + number.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        addfriend(
                                                          action: "edit",
                                                          fname: name
                                                              .split(" ")[0],
                                                          lname: name
                                                              .split(" ")[1],
                                                          number: number,
                                                        )));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 24,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            vmfl.deletefriend(
                                                int.parse(number));
                                            vmfl.fetchfl();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 24,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addfriend()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
