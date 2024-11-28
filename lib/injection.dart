import 'package:get_it/get_it.dart';
import 'package:taskly/data/data_source/database_helper.dart';
import 'package:taskly/data/repository/todo_repository.dart';
import 'package:taskly/domain/repositories/todo_repositories.dart';
import 'package:taskly/domain/usecases/add_todo.dart';
import 'package:taskly/domain/usecases/delete_todo.dart';
import 'package:taskly/domain/usecases/get_todo.dart';
import 'package:taskly/domain/usecases/update_todo.dart';
import 'package:taskly/presentation/cubit/todo_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Database
  locator.registerLazySingleton(() => DatabaseHelper());

  // Repository
  locator
      .registerLazySingleton<TodoRepositories>(() => TodoRepository(locator()));

  // Use cases
  locator.registerLazySingleton(() => GetTodo(todoRepositories: locator()));
  locator.registerLazySingleton(() => AddTodo(todoRepositories: locator()));
  locator.registerLazySingleton(() => UpdateTodo(todoRepositories: locator()));
  locator.registerLazySingleton(() => DeleteTodo(todoRepositories: locator()));

  // Cubit
  locator.registerFactory(
      () => TodoCubit(locator(), locator(), locator(), locator()));
}
