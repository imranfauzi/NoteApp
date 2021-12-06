import 'dart:async';

import 'package:cycle_app/model/PriorityEmoticon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogPopUp extends StatefulWidget {
  int taskId;
  String title;
  String priority;

  DialogPopUp({this.taskId, this.title, this.priority});

  @override
  _DialogPopUpState createState() => _DialogPopUpState();
}

class _DialogPopUpState extends State<DialogPopUp> {
  Timer _timer;
  int _start = 1500;
  bool timerIsStart = false;

  String timer(int sec) {
    int minutes = sec % 1500 ~/ 60;
    int second = sec % 60;
    if (_start == 1500) {
      return "25:00";
    }
    return "${minutes.toString().padLeft(2,'0')}:${second.toString().padLeft(2,'0')}";
  }

  void startTimer() {
    const second = const Duration(seconds: 1);
    _timer = new Timer.periodic(second, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          timerIsStart = true;
          _start--;
        });
      }
    });
  }

  void restartTimer() {
    const second = const Duration(seconds: 1);
    if (_timer != null) {
      setState(() {
        _timer.cancel();
        _start = 1500;
        timerIsStart = false;
      });
    }
  }

  Widget timerButton() {
    if (timerIsStart == false) {
      return ElevatedButton.icon(
        icon: Icon(Icons.timer),
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent, // background
        ),
        label: Text("25Min"),
        onPressed: startTimer,
      );
    } else {
      return ElevatedButton.icon(
        icon: Icon(Icons.refresh_outlined),
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent, // background
        ),
        label: Text("Restart"),
        onPressed: restartTimer,
      );
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: size.height / 6),
      child: AlertDialog(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PriorityEmoticon(priority: widget.priority),
                  SizedBox(width: size.width/30),
                  Text(widget.title.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
               //   SizedBox(width: 10,),
                //  Text(widget.priority)
                ],
              ),
              SizedBox(
                height: size.height / 60,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      timer(_start),
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: (!timerIsStart) ? Container(width: 150, height: 150, child: Icon(Icons.timer, size: 60,),) : Image(
                      image: AssetImage('assets/images/ripple.gif'),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ) ,
                  ),
                ],
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Column(
            children: [
              timerButton(),
              SizedBox(height: 10,),
              ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  icon: Icon(Icons.cancel_outlined),
                  label: Text("Close"),)

            ],
          ),
        ],
      ),
    );
  }
}
