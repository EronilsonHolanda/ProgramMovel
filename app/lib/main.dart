import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}

class TaskData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String taskName) {
    final task = Task(name: taskName);
    tasks.add(task);
    notifyListeners();
  }

  void toggleTaskDone(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => TaskData(),
        child: TaskScreen(),
      ),
    );
  }
}

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: <Widget>[
          TaskList(),
          TaskAdder(),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: taskData.tasks.length,
            itemBuilder: (context, index) {
              final task = taskData.tasks[index];
              return TaskTile(
                taskName: task.name,
                isDone: task.isDone,
                toggleTask: () {
                  taskData.toggleTaskDone(index);
                },
                deleteTask: () {
                  taskData.deleteTask(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  final Function toggleTask;
  final Function deleteTask;

  TaskTile({
    required this.taskName,
    required this.isDone,
    required this.toggleTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskName,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              toggleTask();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteTask();
            },
          ),
        ],
      ),
    );
  }
}

class TaskAdder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskName = '';

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Digite uma nova tarefa',
              ),
              onChanged: (value) {
                newTaskName = value;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (newTaskName.isNotEmpty) {
                Provider.of<TaskData>(context, listen: false).addTask(newTaskName);
              }
            },
          ),
        ],
      ),
    );
  }
}
