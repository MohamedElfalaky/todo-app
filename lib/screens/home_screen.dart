import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list_app_iti_r3/data/app_data.dart';
import 'package:todo_list_app_iti_r3/widgets/task_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;

  void setStatter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: true,
        // visible : _selectedIndex == 0;
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 98, 165, 220),
          onPressed: () {
            showTaskDialog(context);
          },
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 235, 232, 232),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 165, 220),
        title: Text("To Do App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < dataList1.length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = i;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 8.0),
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: _selectedIndex == i
                                    ? Color.fromARGB(255, 98, 165, 220)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                dataList1[i].taskType,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  for (int i = 0;
                      i < dataList1[_selectedIndex].data.length;
                      i++)
                    Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),

                            // dismissible: DismissiblePane(onDismissed: () {}),

                            children: [
                              if (dataList1[_selectedIndex].taskTypeId ==
                                  0) ...[
                                SlidableAction(
                                  // borderRadius: BorderRadius.circular(22),
                                  onPressed: (context) {
                                    setState(() {
                                      Task currentTask = dataList1[0].data[i];
                                      dataList1[0].data.removeAt(i);

                                      dataList1[2].data.add(currentTask);
                                    });
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showTaskDialog(context, index: i);
                                    // dataList1[0].data.removeAt(i);
                                  },
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Update',
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(20)),
                                ),
                              ],
                              if (dataList1[_selectedIndex].taskTypeId ==
                                  2) ...[
                                SlidableAction(
                                  // borderRadius: BorderRadius.circular(22),
                                  onPressed: (context) {
                                    setState(() {
                                      Task currentTask = dataList1[2].data[i];
                                      dataList1[2].data.removeAt(i);

                                      dataList1[0].data.add(currentTask);
                                    });
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 7, 212, 10),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Restore',
                                ),
                              ]
                            ],
                          ),
                          child: TaskContainer(
                            task: dataList1[_selectedIndex].data[i].task,
                            time: dataList1[_selectedIndex].data[i].time,
                            taskTypeId: dataList1[_selectedIndex].taskTypeId,
                            currentIndex: i,
                            upperWidgetSetState: setStatter,
                          ),
                        )),
                  if (dataList1[_selectedIndex].data.isEmpty)
                    Text('Theres no tasks')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showTaskDialog(BuildContext context, {int? index}) {
    var _timeTextEditingController = TextEditingController();
    var _taskTextEditingController = TextEditingController();
    if (index != null) {
      _taskTextEditingController.text = dataList1[0].data[index].task;
      _timeTextEditingController.text = dataList1[0].data[index].time;
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${index == null ? 'Add new' : 'Update'} task'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'task name must not be empty';
                    }
                  },
                  controller: _taskTextEditingController,
                  decoration: InputDecoration(hintText: 'Task name'),
                ),
                InkWell(
                  onTap: () async {
                    var selectedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (selectedTime != null) {
                      _timeTextEditingController.text =
                          selectedTime!.format(context);
                    }
                  },
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Task time must not be empty ';
                      }
                    },
                    controller: _timeTextEditingController,
                    enabled: false,
                    decoration: InputDecoration(hintText: 'Task time'),
                  ),
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (index == null) {
                      setState(() {
                        dataList1[0].data.add(Task(
                            task: _taskTextEditingController.text,
                            time: _timeTextEditingController.text));
                      });
                    } else {
                      setState(() {
                        dataList1[0].data[index].task =
                            _taskTextEditingController.text;
                        dataList1[0].data[index].time =
                            _timeTextEditingController.text;
                      });
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text('${index == null ? 'Save' : 'Update'} ')),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'))
          ],
        );
      },
    );
  }
}
