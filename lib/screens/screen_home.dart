import 'package:database_hive/database/model/todo_model.dart';
import 'package:database_hive/screens/widget/add_todo_widget.dart';
import 'package:database_hive/screens/widget/list_todo_widget.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

int? indexToUpdate;
ValueNotifier<AddButtonMode> buttonMode = ValueNotifier(AddButtonMode.add);

class _ScreenHomeState extends State<ScreenHome> {
  late final TextEditingController _taskNameController;
  late final TextEditingController _descriptionController;
  late FocusNode _taskNameNode;
  late FocusNode _descriptionNode;

  @override
  void initState() {
    _taskNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _taskNameNode = FocusNode();
    _descriptionNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    _taskNameNode.dispose();
    _descriptionNode.dispose();

    super.dispose();
  }

  void bringTaskToupdate(TodoModel todo, int index) {
    _taskNameController.text = todo.taskName;
    _descriptionController.text = todo.description;
    indexToUpdate = index;
    buttonMode.value = AddButtonMode.edit;
    buttonMode.notifyListeners();
  }

  void deleteTask() {
    _taskNameController.clear();
    _descriptionController.clear();
    buttonMode.value = AddButtonMode.add;
    buttonMode.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: const Color.fromARGB(255, 10, 26, 74),
        ),
        body: Column(
          children: [
            AddTodoWidget(
              taskNameController: _taskNameController,
              descriptionController: _descriptionController,
              taskNameNode: _taskNameNode,
              descriptionNode: _descriptionNode,
            ),
            Expanded(
                child: ListTodoWidget(
              callback: (todo1, index) {
                bringTaskToupdate(todo1, index);
              },
              deleteCallback: () {
                deleteTask();
              },
            ))
          ],
        ));
  }
}

enum AddButtonMode { add, edit }
