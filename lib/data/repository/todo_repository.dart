import 'package:dartz/dartz.dart';
import 'package:taskly/data/data_source/database_helper.dart';
import 'package:taskly/data/models/todo_model.dart';
import 'package:taskly/domain/entities/todo.dart';
import 'package:taskly/domain/repositories/todo_repositories.dart';
import 'package:taskly/utils/failures.dart';

class TodoRepository implements TodoRepositories {
  final DatabaseHelper databaseHelper;

  TodoRepository(this.databaseHelper);

  // get todo
  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final db = await databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('todos');

      final List<Todo> todos =
          maps.map((e) => TodoModel.fromMap(e).toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch todos ${e.toString()}'));
    }
  }

  // add todo
  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final db = await databaseHelper.database;
      final model = TodoModel.fromEntity(todo);

      await db.insert('todos', model.toMap());
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add todo ${e.toString()}'));
    }
  }

  // update todo
  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final db = await databaseHelper.database;
      final model = TodoModel.fromEntity(todo);

      await db.update(
        'todos',
        model.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update todo ${e.toString()}'));
    }
  }

  // delete todo
  @override
  Future<Either<Failure, void>> deleteTodo(Todo todo) async {
    try {
      final db = await databaseHelper.database;

      await db.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [todo.id],
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete todo ${e.toString()}'));
    }
  }
}
