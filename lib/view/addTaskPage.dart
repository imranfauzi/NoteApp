import 'package:cycle_app/Custom/cusText.dart';
import 'package:cycle_app/model/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'Homepage.dart';



class AddTaskPage extends StatefulWidget {

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(context: context, builder: (context){
      return AlertDialogCus();
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Color(0xFFF05454),
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () async {
         await showInformationDialog(context);
        });
  }
}






class AlertDialogCus extends StatefulWidget {
  @override
  _AlertDialogCusState createState() => _AlertDialogCusState();
}

class _AlertDialogCusState extends State<AlertDialogCus> {

  String priority="";
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: sizes.height/9),
        child: AlertDialog(
         // actionsPadding: EdgeInsets.symmetric(horizontal: sizes.width/16),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLines: 3,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  controller: _taskController,
                  decoration: InputDecoration(hintText: "Task"),

                ),
                SizedBox(height: 10,),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 5,
                  minLines: 1,
                  controller: _descController,
                  decoration: InputDecoration(hintText: "Description (optional)",),
                ),
                SizedBox(height: 30),
                Text("Categories:", style: TextStyle(fontSize: 14,),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.work_outline_outlined,
                            color: Colors.redAccent,
                          ),
                          iconSize: 20,
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (priority != "Priority") {
                                priority = "Priority";
                                print(priority);
                              } else {
                                priority = "";
                              }
                            });
                          },
                        ),
                        (priority == "Priority")
                            ? cusText("Priority", 14)
                            : SizedBox(
                          height: 0,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.assignment_outlined,
                            color: Colors.amber,
                          ),
                          iconSize: 20,
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (priority != "Medium") {
                                priority = "Medium";
                                print(priority);
                              } else {
                                priority = "";
                              }
                            });
                          },
                        ),
                        (priority == "Medium")
                            ? cusText("Medium", 14)
                            : SizedBox(
                          height: 0,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.alarm,
                            color: Colors.green,
                          ),
                          iconSize: 20,
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (priority != "Normal") {
                                priority = "Normal";
                                print(priority);
                              } else {
                                priority = "";
                              }
                            });
                          },
                        ),
                        (priority == "Normal")
                            ? cusText("Normal", 14)
                            : SizedBox(
                          height: 0,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.assignment_turned_in_outlined,
                            color: Colors.indigoAccent,
                          ),
                          iconSize: 20,
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (priority != "This month") {
                                priority = "This month";
                                print(priority);
                              } else {
                                priority = "";
                              }
                            });
                          },
                        ),
                        (priority == "This month")
                            ? cusText("This month", 14)
                            : SizedBox(
                          height: 0,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.assignment_turned_in_outlined,
                            color: Colors.purpleAccent,
                          ),
                          iconSize: 20,
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (priority != "This week") {
                                priority = "This week";
                                print(priority);
                              } else {
                                priority = "";
                              }
                            });
                          },
                        ),
                        (priority == "This week")
                            ? cusText("This week", 14)
                            : SizedBox(
                          height: 0,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.assignment_turned_in_outlined,
                            color: Colors.pinkAccent,
                          ),
                          iconSize: 20,
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (priority != "Tomorrow") {
                                priority = "Tomorrow";
                                print(priority);
                              } else {
                                priority = "";
                              }
                            });
                          },
                        ),
                        (priority == "Tomorrow")
                            ? cusText("Tomorrow", 14)
                            : SizedBox(
                          height: 0,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
               // Text("- normal\n- medium\n- priority\n- tomorrow\n- this week\n- this month",  style: TextStyle(fontSize: 14,))
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),

                    child: Text("Cancel", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed("/");

                      //     Get.to(() => Homepage());
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // background
                      onPrimary: Colors.white, // foreground
                    ),

                    child: Text("Save", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    onPressed: () async {
                      //
                      // if(_descController.text.length>0 || priority.length>0) {
                      //     _descController.text = "";
                      //     priority="";
                      // }
                      await DatabaseHelper.instance.insertTask(Task(
                        title: _taskController.text,
                        desc: _descController.text,
                        priority: priority,
                        finished: "false",
                      ));
                      setState(() {

                      });
                      Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed("/");


                 //     Get.to(() => Homepage());
                    }),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
