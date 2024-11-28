import 'package:taskly/domain/entities/todo.dart';

class TodoModel {
  final int id;
  final String text;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.text,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      text: map['text'] as String,
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Todo toEntity() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      text: todo.text,
      isCompleted: todo.isCompleted,
    );
  }
}
