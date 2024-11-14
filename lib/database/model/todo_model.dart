import 'package:hive_flutter/adapters.dart';
part 'todo_model.g.dart';
@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final bool isCompleted;

  TodoModel({required this.taskName, required this.description, required this.isCompleted});

   TodoModel copyWith({
    String? taskName,
    String? description,
    bool? isCompleted,
  }) {
    return TodoModel(
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  
}