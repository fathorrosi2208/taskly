import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/domain/entities/todo.dart';
import 'package:taskly/domain/usecases/add_todo.dart';
import 'package:taskly/domain/usecases/delete_todo.dart';
import 'package:taskly/domain/usecases/get_todo.dart';
import 'package:taskly/domain/usecases/update_todo.dart';

enum TodoStatus { initial, loading, loaded, error }

class TodoState {
  final TodoStatus status;
  final List<Todo> todos;
  final String? errorMessage;

  TodoState({
    required this.status,
    required this.todos,
    this.errorMessage,
  });

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    String? errorMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class TodoCubit extends Cubit<TodoState> {
  final AddTodo addTodo;
  final GetTodo getTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoCubit(
    this.addTodo,
    this.getTodo,
    this.updateTodo,
    this.deleteTodo,
  ) : super(TodoState(status: TodoStatus.initial, todos: [])) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    emit(state.copyWith(status: TodoStatus.loading));

    final result = await getTodo.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message,
      )),
      (todos) => emit(state.copyWith(
        status: TodoStatus.loaded,
        todos: todos,
      )),
    );
  }

  Future<void> addTodoItem(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    final result = await addTodo.execute(newTodo);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message,
      )),
      (_) => loadTodos(),
    );
  }

  Future<void> updateTodoItem(Todo todo) async {
    final updatedTodo = todo.toggleCompleted();

    final result = await updateTodo.execute(updatedTodo);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message,
      )),
      (_) => loadTodos(),
    );
  }

  Future<void> deleteTodoItem(Todo todo) async {
    final result = await deleteTodo.execute(todo);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message,
      )),
      (_) => loadTodos(),
    );
  }
}
