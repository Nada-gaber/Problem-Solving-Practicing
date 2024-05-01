import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dart_task/task_model.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  // Method to add a new task
  void addTask(String title, String description, ) {
    setState(() {
      tasks.add(Task(
          title: title, description: description, isCompleted: false,));
    });
    saveTasks(); // Save updated tasks to SharedPreferences
  }

  // Method to remove a task
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks(); // Save updated tasks to SharedPreferences
  }

  Future<void> loadTask() async {
    final prefs = await SharedPreferences.getInstance();
    final encodeData = prefs.getStringList('tasks');
    if (encodeData != null) {
      tasks =
          encodeData.map((data) => Task.fromJson(jsonDecode(data))).toList();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = tasks.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList('tasks', encodedData);
  }

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  @override
  void dispose() {
    super.dispose();
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To-do Taks'),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Title'),
                    onSubmitted: (value) => _addNewTask(value, '',),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addNewTask('', '',),
                ),
              ],
            ),
          ),
            Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: ((context, index) {
                    final task = tasks[index];
                    return ListTile(
                        title: Text(task.title.toString()),
                        subtitle: Text(task.description.toString()),
                        trailing: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              setState(() {
                                task.isCompleted = !true;
                              });
                            }));
                  })),
            ),
          ],
        ));
  }
  // Helper method to handle adding new tasks with optional description
  void _addNewTask(String title, String description) {
    if (title.isNotEmpty) {
      addTask(title, description);
    }
  }

}
