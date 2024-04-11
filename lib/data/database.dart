import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List taskLists = [];
  final _mybox = Hive.box('mybox');

  //* When it is the first time openning the app this method will run
  void createInitialTasksOrData() {
    taskLists = [
      ["Do Excersises", false],
      ["Take a shower", false],
    ];
  }

  //* Loading the data from the database(box)
  void LoadData() {
    taskLists = _mybox.get("TASKLISTS");
  }

  //* Update database
  void updateDatabase() {
    _mybox.put("TASKLISTS", taskLists);
  }
}
