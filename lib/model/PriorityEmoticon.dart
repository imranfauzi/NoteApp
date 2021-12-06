import 'package:flutter/material.dart';



class PriorityEmoticon extends StatelessWidget {
  const PriorityEmoticon({
    Key key,
    @required this.priority,
  }) : super(key: key);

  final String priority;

  @override
  Widget build(BuildContext context) {
    if (priority == "Normal") {
      return Icon(
        Icons.alarm,
        color: Colors.green,
      );
    }
    if (priority == "Medium") {
      return Icon(
        Icons.assignment,
        color: Colors.yellow,
      );
    }
    if (priority == "Priority") {
      return Icon(
        Icons.work_outline_outlined,
        color: Colors.red,
      );
    }
    if (priority == "Tomorrow") {
      return Icon(
        Icons.assignment_turned_in_outlined,
        color: Colors.pink,
      );
    }
    if (priority == "This week") {
      return Icon(
        Icons.assignment_turned_in_outlined,
        color: Colors.purple,
      );
    }
    if (priority == "This month") {
      return Icon(
        Icons.assignment_turned_in_outlined,
        color: Colors.blue,
      );
    } else {
      return Icon(
        Icons.alarm,
        color: Colors.green,
      );
    }
  }
}
