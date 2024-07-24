import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list_app_iti_r3/data/app_data.dart';
import 'package:todo_list_app_iti_r3/widgets/task_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 98, 165, 220),
        onPressed: () {},
        child: Icon(Icons.add),
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
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < dataList.length; i++)
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
                              dataList[i]['taskType'],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  for (int i = 0;
                      i < dataList[_selectedIndex]['data'].length;
                      i++)
                    TaskContainer(
                      task: dataList[_selectedIndex]['data'][i]['task'],
                      time: dataList[_selectedIndex]['data'][i]['time'],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
