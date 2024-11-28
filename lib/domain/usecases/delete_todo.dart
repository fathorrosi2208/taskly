import 'package:dartz/dartz.dart';
import 'package:taskly/domain/entities/todo.dart';
import 'package:taskly/domain/repositories/todo_repositories.dart';
import 'package:taskly/utils/failures.dart';

class DeleteTodo {
  final TodoRepositories todoRepositories;

  DeleteTodo({required this.todoRepositories});

  Future<Either<Failure, void>> execute(Todo todo) async {
    return await todoRepositories.deleteTodo(todo);
  }
}
