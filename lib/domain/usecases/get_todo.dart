import 'package:dartz/dartz.dart';
import 'package:taskly/domain/entities/todo.dart';
import 'package:taskly/domain/repositories/todo_repositories.dart';
import 'package:taskly/utils/failures.dart';

class GetTodo {
  final TodoRepositories todoRepositories;

  GetTodo({required this.todoRepositories});

  Future<Either<Failure, List<Todo>>> execute() async {
    return await todoRepositories.getTodos();
  }
}
