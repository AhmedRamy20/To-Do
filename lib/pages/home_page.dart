// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/utils/dialog_block.dart';
import 'package:to_do/utils/to_do_tile_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //! reference the box
  final _mybox = Hive.box('mybox');
  ToDoDatabase myDatabase = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get("TASKLISTS") == null) {
      myDatabase.createInitialTasksOrData();
    } else {
      myDatabase.LoadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  // List taskLists = [
  //   ["Do Excersise", false],
  //   ["Take Shower", false],
  // ];

  //! method for the taped checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      myDatabase.taskLists[index][1] = !myDatabase.taskLists[index][1];
    });
    myDatabase.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBlock(
          myController: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      myDatabase.taskLists.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    myDatabase.updateDatabase();
  }

  void deletedTask(int index) {
    setState(() {
      myDatabase.taskLists.removeAt(index);
    });
    myDatabase.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff26425A),
      appBar: AppBar(
        title: const Text("To Do"),
        centerTitle: true,
        backgroundColor: Color(0xff0F969C),
        elevation: 0,
      ),
      //! Floating button for adding a new task
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0F969C),
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: myDatabase.taskLists.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: myDatabase.taskLists[index][0],
            taskCompleted: myDatabase.taskLists[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deletedTask(index),
          );
        },
      ),
    );
  }
}
