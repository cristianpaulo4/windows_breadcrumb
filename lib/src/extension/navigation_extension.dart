import 'package:flutter/widgets.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

extension NavigatorExtension on NavigatorState {
  Future<Object?> navigateTo(String route, {Object? arguments}) async {
    return await navigatorKey.currentState?.pushNamed(
      route,
      arguments: arguments,
    );
  }

  Future<Object?> navigateBack({Object? arguments}) async {
    return await navigatorKey.currentState?.maybePop(arguments);
  }
}
