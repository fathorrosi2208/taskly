import 'package:dartz/dartz.dart';
import 'package:taskly/domain/entities/todo.dart';
import 'package:taskly/utils/failures.dart';

abstract class TodoRepositories {
  // get list of todo
  Future<Either<Failure, List<Todo>>> getTodos();
  // add a new todo
  Future<Either<Failure, void>> addTodo(Todo todo);
  // update an existing todo
  Future<Either<Failure, void>> updateTodo(Todo todo);
  // delete a todo
  Future<Either<Failure, void>> deleteTodo(Todo todo);
}
