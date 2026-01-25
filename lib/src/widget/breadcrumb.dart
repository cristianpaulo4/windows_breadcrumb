import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BreadCrumb extends StatefulWidget {
  const BreadCrumb({
    super.key,
    required this.itemInitial,
    required this.pages,
    this.chevronIconSize,
    this.divider,
  });
  final ItemPage itemInitial;
  final List<ItemPage> pages;
  final double? chevronIconSize;
  final Widget? divider;

  @override
  State<BreadCrumb> createState() => _BreadCrumbState();
}

class _BreadCrumbState extends State<BreadCrumb> {
  late AppRouteObserver observer;
  List<BreadcrumbItem<String>> breadcrumb = [];

  @override
  void initState() {
    super.initState();
    breadcrumb.add(
      BreadcrumbItem(
        label: Text(widget.itemInitial.label),
        value: widget.itemInitial.route,
      ),
    );
    observer = AppRouteObserver(onPush: _handleRoutePush, onPop: onPop);
  }

  void onPop(Route? route) {
    if (route?.settings.name == null || !mounted || breadcrumb.length == 1) {
      return;
    }
    int index = breadcrumb.indexWhere((e) => e.value == route?.settings.name);
    if (index == -1) return;
    breadcrumb.removeRange(index + 1, breadcrumb.length);
    setState(() {});
  }

  void _handleRoutePush(Route? route) {
    if (route?.settings.name == null || !mounted) return;
    if (route?.settings.name == '/') return;
    if (breadcrumb.first.value == route?.settings.name) {
      breadcrumb.removeRange(1, breadcrumb.length);
    }
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
          chevronIconSize: widget.chevronIconSize ?? 8,
          chevronIconBuilder: (context, item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
              ).copyWith(top: 4),
              child:
                  widget.divider ??
                  Icon(WindowsIcons.chevron_right_small, size: 10),
            );
          },
          chevronAlignment: ChevronAlignment.center,

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
              if (settings.name == '/') {
                return widget.itemInitial.body;
              }

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
  final Function(Route?) onPop;
  AppRouteObserver({required this.onPush, required this.onPop});

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    onPush(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onPop(previousRoute);
  }
}
