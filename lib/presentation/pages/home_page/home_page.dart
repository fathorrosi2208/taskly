import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskly/main.dart';
import 'package:taskly/presentation/cubit/todo_cubit.dart';
import 'package:taskly/presentation/pages/home_page/components/app_drawer.dart';
import 'package:taskly/utils/helpers/helper_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showAddTodoDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Add Todo'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your todo',
                  ),
                  autofocus: true,
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        context.read<TodoCubit>().addTodoItem(controller.text);
                        context.pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a todo'),
                          ),
                        );
                      }
                    },
                    child: const Text('Add'),
                  )
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: HelperFunction.isDarkMode(context)
                  ? $styles.colors.light
                  : $styles.colors.dark,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == TodoStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          }

          if (state.todos.isEmpty) {
            return const Center(
              child: Text('No todos found'),
            );
          }

          return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return ListTile(
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                      decorationThickness: 2.0,
                      color: HelperFunction.isDarkMode(context)
                          ? $styles.colors.lightTextPrimary
                          : $styles.colors.darkTextPrimary,
                    ),
                  ),
                  leading: Checkbox(
                    checkColor: HelperFunction.isDarkMode(context) ? $styles.colors.dark : $styles.colors.light,
                    value: todo.isCompleted,
                    onChanged: (value) {
                      context.read<TodoCubit>().updateTodoItem(todo);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: HelperFunction.isDarkMode(context)
                          ? $styles.colors.light
                          : $styles.colors.dark,
                    ),
                    onPressed: () {
                      context.read<TodoCubit>().deleteTodoItem(todo);
                    },
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: Icon(
          Icons.add,
          color: HelperFunction.isDarkMode(context)
              ? $styles.colors.dark
              : $styles.colors.light,
        ),
      ),
    );
  }
}
