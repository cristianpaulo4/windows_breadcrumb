import 'package:flutter/widgets.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

extension NavigatorExtension on NavigatorState {
  void navigateTo(String route, {Object? arguments}) {
    navigatorKey.currentState!.pushNamed(route, arguments: arguments);
  }
}
