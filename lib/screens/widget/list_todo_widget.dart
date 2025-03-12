

import 'package:database_hive/database/function/db_functions.dart';
import 'package:database_hive/database/model/todo_model.dart';
import 'package:database_hive/main.dart';
import 'package:database_hive/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListTodoWidget extends StatelessWidget {
  final void Function(TodoModel todo1, int index) callback;
  final void Function() deleteCallback;

  const ListTodoWidget(
      {super.key, required this.callback, required this.deleteCallback});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (BuildContext context, Box<TodoModel> todoModelBox, _) {
          List<TodoModel> todolist = todoModelBox.values.toList();
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final data = todolist[index];
                // log(todolist.length.toString());
                return Card(
                  color: const Color.fromARGB(255, 136, 196, 245),
                  child: ListTile(
                    leading: Checkbox(
                        activeColor: const Color.fromARGB(255, 72, 161, 75),
                        shape: const CircleBorder(),
                        // fillColor: WidgetStatePropertyAll(Colors.white38),
                        value: data.isCompleted,
                        onChanged: (value) {
                          bool isChanged = data.isCompleted ? false : true;
                          final updatedData =
                              data.copyWith(isCompleted: isChanged);
                          // final todo = TodoModel(
                          //     taskName: data.taskName,
                          //     description: data.description,
                          //     isCompleted: isChanged);

                          DbFunctions().updatetask(updatedData, index);
                        }),
                    title: Text(data.taskName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              buttonMode.value = AddButtonMode.edit;
                              callback(data, index);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black45,
                            )),
                        IconButton(
                            onPressed: () {
                              deleteCallback();
                              DbFunctions().deleteTask(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 77, 73, 73),
                            )),
                      ],
                    ),
                    subtitle: Text(data.description),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 7,
                );
              },
              itemCount: todolist.length);
        });
  }
}
