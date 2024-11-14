// created first todo

import 'package:database_hive/database/model/todo_model.dart';
import 'package:database_hive/main.dart';

class DbFunctions {
  Future<void> addTask(String taskName, String description) async {
    final newTask = TodoModel(
      taskName: taskName,
      description: description,
      isCompleted: false,
    );
    await todoBox.add(newTask);
  }

  void deleteTask(int index1) async {
    await todoBox.deleteAt(index1);
  }

  void updatetask(TodoModel todotask, int indextoUpdate) async {
    await todoBox.putAt(indextoUpdate, todotask);
  }
}
