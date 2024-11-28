import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/presentation/components/app_scaffold.dart';
import 'package:taskly/presentation/cubit/todo_cubit.dart';
import 'package:taskly/presentation/theme/app_style.dart';
import 'package:taskly/utils/router.dart';
import 'package:taskly/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<TodoCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return AppScaffold(
            child: child!,
          );
        },
        themeMode: ThemeMode.system,
        theme: $styles.toThemeData(),
        darkTheme: $styles.toThemeData(isDark: true),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}

AppStyle get $styles => AppScaffold.style;
