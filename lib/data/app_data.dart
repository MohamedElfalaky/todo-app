List<TaskList> dataList1 = [
  TaskList(taskType: 'To Do', taskTypeId: 0, data: [
    Task(task: 'Meet ITI students', time: '5 PM'),
    Task(task: 'Eat break fast', time: '8 AM'),
    Task(task: 'Meet ITI students', time: '5 pm'),
  ]),
  TaskList(
      taskType: 'Done',
      taskTypeId: 1,
      data: [Task(task: 'Finish Flutter Course', time: '8 PM')]),
  TaskList(taskType: 'Deleted', taskTypeId: 2, data: []),
  // TaskList(taskType: 'In progress', taskTypeId: 3, data: []),
];

class TaskList {
  final String taskType;
  final int taskTypeId;
  final List<Task> data;

  TaskList(
      {required this.taskType, required this.data, required this.taskTypeId});

  factory TaskList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Task> taskList = list.map((i) => Task.fromJson(i)).toList();

    return TaskList(
      taskType: json['taskType'],
      taskTypeId: json['taskTypeId'],
      data: taskList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskType': taskType,
      'data': data.map((task) => task.toJson()).toList(),
    };
  }
}

class Task {
  String task;
  String time;

  Task({
    required this.task,
    required this.time,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      task: json['task'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'time': time,
    };
  }
}
