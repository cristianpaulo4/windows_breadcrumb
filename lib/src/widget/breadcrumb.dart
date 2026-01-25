import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BreadCrumb extends StatefulWidget {
  BreadCrumb({super.key, required this.itemInitial, required this.pages});
  final ItemDrawer itemInitial;
  final List<ItemPage> pages;

  @override
  State<BreadCrumb> createState() => _BreadCrumbState();
}

class _BreadCrumbState extends State<BreadCrumb> {
  List<BreadcrumbItem<String>> breadcrumb = [];
  late AppRouteObserver observer;

  @override
  void initState() {
    super.initState();
    breadcrumb.add(
      BreadcrumbItem(
        label: Text(widget.itemInitial.label),
        value: widget.itemInitial.route,
      ),
    );
    observer = AppRouteObserver(onPush: _handleRoutePush);
  }

  void _handleRoutePush(Route? route) {
    if (route?.settings.name == null || !mounted) return;
    if (route?.settings.name == '/') return;
    if (breadcrumb.any((e) => e.value == route!.settings.name)) return;

    final pageData = widget.pages.firstWhere(
      (element) => element.route == route!.settings.name,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          breadcrumb.add(
            BreadcrumbItem(label: Text(pageData.label), value: pageData.route),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: BreadcrumbBar<String>(
          items: breadcrumb,
          onItemPressed: (item) {
            final index = breadcrumb.indexOf(item);
            breadcrumb.removeRange(index + 1, breadcrumb.length);
            setState(() {});
            navigatorKey.currentState?.popUntil(
              (route) => route.settings.name == item.value,
            );
          },
        ),
      ),
      content: Navigator(
        key: navigatorKey,
        initialRoute: widget.itemInitial.route,
        observers: [observer],
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
            settings: settings,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget.pages
                  .firstWhere((e) => e.route == settings.name)
                  .body;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return child;
                },
          );
        },
      ),
    );
  }
}

class AppRouteObserver extends NavigatorObserver {
  final Function(Route?) onPush;
  AppRouteObserver({required this.onPush});

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    onPush(route);
  }
}
