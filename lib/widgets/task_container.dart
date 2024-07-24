import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  String task;
  String time;
  TaskContainer({super.key, required this.task, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            task,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        ],
      ),
    );
  }
}
