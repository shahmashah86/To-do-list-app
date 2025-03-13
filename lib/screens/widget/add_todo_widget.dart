import 'dart:developer';

import 'package:database_hive/database/function/db_functions.dart';
import 'package:database_hive/database/model/todo_model.dart';
import 'package:database_hive/screens/screen_home.dart';
import 'package:flutter/material.dart';

class AddTodoWidget extends StatelessWidget {
  final TextEditingController taskNameController;
  final TextEditingController descriptionController;
  final FocusNode taskNameNode;
  final FocusNode descriptionNode;
  AddTodoWidget(
      {super.key,
      required this.taskNameController,
      required this.descriptionController,
      required this.taskNameNode,
      required this.descriptionNode});

  final DbFunctions dbFunctions = DbFunctions();

  @override
  Widget build(BuildContext context) {
    return // Text("hii")
        SizedBox(
      width: double.infinity
      ,
      height: 270,
      child: Card(
        color: const Color.fromARGB(255, 136, 196, 245),
        elevation: 10,
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                focusNode: descriptionNode,
                controller: taskNameController,
                decoration: const InputDecoration(
                    hintText: "Taskname",
                    filled: true,
                    fillColor: Colors.white38,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 29, 73)))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  focusNode: taskNameNode,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Description",
                      filled: true,
                      fillColor: Colors.white38,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 4, 29, 73))))),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(221, 32, 27, 27)),
                          side: WidgetStatePropertyAll(BorderSide(
                              color: Color.fromARGB(255, 4, 29, 73))),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.white38,
                          )),
                      onPressed: () async {
                        if (buttonMode.value == AddButtonMode.add) {
                          final todotask = TodoModel(
                              taskName: taskNameController.text.trim(),
                              description: descriptionController.text.trim(),
                              isCompleted: false);

                          if (todotask.taskName == "" ||
                              todotask.description == "") {
                            return;
                          } else {
                            log(todotask.toString(), name: "Task to add");
                            await dbFunctions.addTask(
                                todotask.taskName, todotask.description);
                          }
                          Future.delayed(const Duration(seconds: 2));
                          taskNameController.clear();
                          descriptionController.clear();
                        } else {
                          buttonMode.value = AddButtonMode.add;
                          buttonMode.notifyListeners();
                          final todotask = TodoModel(
                              taskName: taskNameController.text.trim(),
                              description: descriptionController.text.trim(),
                              isCompleted: false);

                          if (todotask.taskName == "" ||
                              todotask.description == "") {
                            return;
                          } else {
                            dbFunctions.updatetask(todotask, indexToUpdate!);
                          }
                          Future.delayed(const Duration(seconds: 2));
                          taskNameController.clear();
                          descriptionController.clear();
                        }
                        taskNameNode.unfocus();
                        descriptionNode.unfocus();
                      },
                      child: ValueListenableBuilder(
                          valueListenable: buttonMode,
                          builder: (BuildContext content, AddButtonMode mode,
                              Widget? _) {
                            return Text(
                              mode.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            );
                          })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
