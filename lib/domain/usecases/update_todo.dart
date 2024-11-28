import 'package:dartz/dartz.dart';
import 'package:taskly/domain/entities/todo.dart';
import 'package:taskly/domain/repositories/todo_repositories.dart';
import 'package:taskly/utils/failures.dart';

class UpdateTodo {
  final TodoRepositories todoRepositories;

  UpdateTodo({required this.todoRepositories});

  Future<Either<Failure, void>> execute(Todo todo) async {
    return todoRepositories.updateTodo(todo);
  }
}
