import 'package:go_router/go_router.dart';
import 'package:taskly/presentation/components/app_scaffold.dart';
import 'package:taskly/presentation/pages/home_page/home_page.dart';

GoRouter buildRouter() {
  return GoRouter(initialLocation: '/', routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppScaffold(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
  ]);
}

final router = buildRouter();
