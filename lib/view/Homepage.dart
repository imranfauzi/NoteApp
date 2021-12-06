import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cycle_app/model/PriorityEmoticon.dart';
import 'package:cycle_app/model/QuoteModel.dart';
import 'package:cycle_app/model/db_helper.dart';
import 'package:cycle_app/view/DialogPopUp.dart';
import 'package:cycle_app/view/addTaskPage.dart';
import 'package:cycle_app/view/Setting.dart';
import 'package:cycle_app/view/updateTaskPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var isDay = true;
  var priority = "";
  var title = "";
  var description = "";
  var isBigger = false;
  var finished = "false";
  int taskId;

  String quote = '"No internet, no quote, Sorry!"';
  String author = "-imran fauzi-";

  Future<QuoteModel> futureQuote;

  String localTime() {
    var now = new DateTime.now();
    return new DateFormat("HH:mm").format(now);
  }

  Widget QuoteTimer(int id) {
    if (isBigger == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"The time has come when you need a support but you cant"',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '-Imran Fauzi-',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          )
        ],
      );
    }
  }

  dialogPopUp(BuildContext context, int taskId, String title, String priority) {

    showDialog(context: context, barrierDismissible: true,builder: (context){
      return DialogPopUp(taskId: taskId, title: title, priority: priority,);
    });

  }

  //IsFinish= line through
  textCustom(String text, String finished) {
    if(finished=="false") {
      return Text(text);
    } else {
      return Text(text, style: TextStyle( decoration: TextDecoration.lineThrough),);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBigger = false;
    futureQuote = getQuote();
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: AddTaskPage(),
      //   backgroundColor: Color(0xFF222831),
      body: SafeArea(
        child: Stack(
          children: [
            /** List view **/
            Padding(
              padding: EdgeInsets.only(
                  top: sizes.height / 2.2, left: sizes.width / 20),
              child: Container(
                  child: FutureBuilder<List<Task>>(
                      future: DatabaseHelper.instance.queryAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Task>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                List items = snapshot.data;
                                Task item = snapshot.data[index];
                                priority = item.priority;
                                return Slidable(
                                  key: new Key(item.taskId.toString()),
                                  endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_){
                                          DatabaseHelper.instance.delete(item.taskId);
                                          setState(() {  });
                                          Scaffold.of(context)
                                              .showSnackBar(new SnackBar(
                                            content: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Item deleted',
                                                  style:
                                                  TextStyle(color: Colors.white,),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.black,
                                          ));
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                      SlidableAction(
                                        onPressed: (_) => Scaffold.of(context)
                                          .showSnackBar(new SnackBar(
                                      content: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                      Text(
                                      'Edit feature is in development',
                                      style:
                                      TextStyle(color: Colors.white,),
                                      ),
                                      ],
                                      ),
                                      backgroundColor: Colors.black,
                                      )),
                                            // Get.to(UpdateTaskPage(),
                                            // arguments: [item.taskId, item.title,item.desc,item.priority, item.finished,]),
                                        backgroundColor: Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      )
                                    ],
                                  ),
                                  child: ListTile(
                                    horizontalTitleGap: 20,
                                    onLongPress: () {
                                      DatabaseHelper.instance.update(Task(
                                        taskId: item.taskId,
                                        desc: item.desc,
                                        priority: item.priority,
                                        title: item.title,
                                        finished: (item.finished=="false") ? "true" : "false",
                                      ));
                                      setState(() {});
                                    },
                                    onTap: () {
                                      setState(() {});
                                      dialogPopUp(context, item.taskId, item.title, item.priority);
                                      print("tile ditap ${item.taskId}");
                                    },
                                    leading: PriorityEmoticon(priority: priority),
                                    title: textCustom(item.title, item.finished),
                                    subtitle: textCustom(item.desc, item.finished)
                                  ),
                                );
                              });
                        } else{
                          return Icon(Icons.note_add_outlined);
                        }

                      })),
            ),
            /** Local Time **/
            TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Text(
                    localTime(),
                    style: TextStyle(
                        fontFamily: "Muli",
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                ),
              );
            }),
            /** Daylight Image **/
            Padding(
                padding: EdgeInsets.all(40),
                child: Image(
                  image: AssetImage('assets/images/daylightt.gif'),
                  height: sizes.height / 6,
                )),
            /** Quote & Timer **/
            Padding(
              padding:
                  EdgeInsets.only(top: sizes.height / 5, left: sizes.width / 20),
              child: Column(
                children: [
                  Text("If you don't plan, you plan to failure",
                      style: TextStyle(fontSize: 20,)),
                  SizedBox(height: 10,),
                  Text("-anon-", style: TextStyle(fontSize: 15),)
                ],
              ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     FutureBuilder<QuoteModel>(
              //       future: futureQuote,
              //         builder: (context, snapshot){
              //         if(snapshot.hasData){
              //           final quote1 = snapshot.data;
              //           quote = quote1.q;
              //           author = quote1.a;
              //
              //           print(getQuote());
              //           return  Column(
              //             children: [
              //               Text(
              //                 '"$quote"',
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Text(
              //                 '-$author-',
              //                 style: TextStyle(
              //                   fontSize: 15,
              //                 ),
              //               ),
              //             ],
              //           );
              //         } else if (snapshot.hasError){
              //           return Text(snapshot.error.toString());
              //         }
              //         return Center(child: CircularProgressIndicator());
              //
              //         }),
              //   ],
              // ),
            ),
            /** Setting Button **/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  alignment: Alignment.center,
                  iconSize: 30,
                  splashRadius: 30,
                  color: Color(0xFFdddddd),
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Get.to(() => SettingsPage(),transition: Transition.zoom);
                    //Navigator.of(context).pushReplacementNamed('/setting');

                    //getQuote();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<QuoteModel> getQuote() async {
  final url = Uri.parse("https://zenquotes.io/api/today");
  final response = await http.get(url);

  if(response.statusCode == 200) {
    final jsonQuote = jsonDecode(response.body);
    return QuoteModel.fromJson(jsonQuote[0]);
  } else {
    throw Exception("Fail to load QuoteModel");
  }


}


// {
// DatabaseHelper.instance.delete(item.taskId);

// },