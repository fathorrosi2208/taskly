import 'package:flutter/material.dart';
import 'package:taskly/presentation/theme/app_style.dart';
import 'package:taskly/presentation/theme/components/app_scroll_behavior.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.withSafeArea = true,
  });

  final Widget child;
  final bool withSafeArea;
  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    _style = AppStyle(screenSize: MediaQuery.of(context).size);

    return KeyedSubtree(
      key: ValueKey(_style.scale),
      child: Theme(
        data: _style.toThemeData(
            isDark: Theme.of(context).brightness == Brightness.dark),
        child: DefaultTextStyle(
          style: _style.text.bodyMedium,
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: withSafeArea ? SafeArea(child: child) : child,
          ),
        ),
      ),
    );
  }
}
