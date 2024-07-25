import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_app_iti_r3/data/app_data.dart';

class TaskContainer extends StatefulWidget {
  String task;
  String time;
  Function upperWidgetSetState;
  final int currentIndex;
  final int taskTypeId;

  // 0 ==> ToDo
  // 1 ==> Done
  // 2 ==> Deleted
  // 3 ==> in Progress

  TaskContainer(
      {super.key,
      required this.task,
      required this.time,
      required this.taskTypeId,
      required this.currentIndex,
      required this.upperWidgetSetState});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    // if (widget.taskTypeId == 0) {
    //   isChecked = false;
    // } else {
    //   isChecked = true;
    // }

    // print('is checked $isChecked');
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(22))),
      padding: EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.taskTypeId == 0 || widget.taskTypeId == 1)
            Checkbox(
              value: widget.taskTypeId == 0 ? false : true,
              onChanged: (value) {
                if (widget.taskTypeId == 0) {
                  var task = dataList1[0].data[widget.currentIndex];

                  dataList1[1].data.add(task);
                  dataList1[0].data.removeAt(widget.currentIndex);

                  widget.upperWidgetSetState();
                } else {
                  var task = dataList1[1].data[widget.currentIndex];

                  dataList1[0].data.add(task);
                  dataList1[1].data.removeAt(widget.currentIndex);

                  widget.upperWidgetSetState();
                }
              },
            ),
          Text(
            widget.task,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration:
                  widget.taskTypeId == 1 ? TextDecoration.lineThrough : null,
            ),
          ),
          Spacer(),
          Text(widget.time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        ],
      ),
    );
  }
}
