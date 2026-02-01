import 'package:fluent_ui/fluent_ui.dart';

import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BreadCrumb extends StatefulWidget {
  const BreadCrumb({
    super.key,
    required this.itemInitial,
    required this.pages,
    this.chevronIconSize,
    this.divider,
    this.color = Colors.black,
    this.fontSize,
  });
  final ItemPage itemInitial;
  final List<ItemPage> pages;
  final double? chevronIconSize;
  final Widget? divider;
  final Color color;
  final double? fontSize;

  @override
  State<BreadCrumb> createState() => _BreadCrumbState();
}

class _BreadCrumbState extends State<BreadCrumb> {
  late AppRouteObserver observer;
  List<BreadcrumbItem<String>> breadcrumb = [];
  late Color color;

  TextStyle get getStyle {
    return TextStyle(
      color: color,
      fontSize: widget.fontSize,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  void initState() {
    super.initState();
    color = widget.color;
    breadcrumb.add(
      BreadcrumbItem(
        label: Text(
          widget.itemInitial.title ?? widget.itemInitial.label,
          style: getStyle,
        ),
        value: widget.itemInitial.route!,
      ),
    );
    observer = AppRouteObserver(onPush: _handleRoutePush, onPop: onPop);
  }

  void onPop(Route? route) {
    if (route?.settings.name == null || !mounted || breadcrumb.length == 1) {
      final text = breadcrumb[0].label as Text;
      breadcrumb[0] = BreadcrumbItem(
        label: Text(text.data!, style: getStyle),
        value: breadcrumb[0].value,
      );
      return;
    }
    int index = breadcrumb.indexWhere((e) => e.value == route?.settings.name);
    if (index == -1) return;

    breadcrumb.removeRange(index + 1, breadcrumb.length);
    final lastItem = breadcrumb.last;
    final indexLastItem = breadcrumb.indexOf(lastItem);
    final text = lastItem.label as Text;
    breadcrumb[indexLastItem] = BreadcrumbItem(
      label: Text(text.data!, style: getStyle),
      value: lastItem.value,
    );
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
        final title = pageData.title ?? pageData.label;
        breadcrumb = alterColorText(route);

        setState(() {
          breadcrumb.add(
            BreadcrumbItem(
              label: Text(title, style: getStyle),
              value: pageData.route!,
            ),
          );
        });
      }
    });
  }

  List<BreadcrumbItem<String>> alterColorText(Route? route) {
    if (breadcrumb.last.value != route!.settings.name) {
      return breadcrumb.map((e) {
        final pageData = widget.pages.firstWhere(
          (element) => element.route == e.value,
        );
        return BreadcrumbItem(
          label: Text(
            pageData.title ?? pageData.label,
            style: getStyle.copyWith(color: color.withAlpha(150)),
          ),
          value: e.value,
        );
      }).toList();
    }
    return breadcrumb;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BreadcrumbBar<String>(
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
        //initialRoute: "settings",
        observers: [observer],
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
            settings: settings,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            pageBuilder: (context, animation, secondaryAnimation) {
              if (settings.name == '/') {
                return widget.itemInitial.body!;
              }

              return widget.pages
                  .firstWhere((e) => e.route == settings.name)
                  .body!;
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
