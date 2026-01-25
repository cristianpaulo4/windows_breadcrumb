import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/src/widget/bar_windows.dart';
import 'package:windows_breadcrumb/src/widget/breadcrumb.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BreadCrumbBody extends StatefulWidget {
  const BreadCrumbBody({
    super.key,
    required this.pages,
    this.header,
    this.footer,
  });
  final List<ItemPage> pages;
  final Widget? header;
  final Widget? footer;

  @override
  State<BreadCrumbBody> createState() => _BreadCrumbBodyState();
}

class _BreadCrumbBodyState extends State<BreadCrumbBody> {
  int _selectedIndex = 0;

  List<ItemPage> get drawerMenus {
    return widget.pages.where((e) => e.isDrawer).toList();
  }

  List<ItemPage> get pagesNavigator {
    return widget.pages
        .expand((page) => [page, if (page.pages != null) ...page.pages!])
        .toList();
  }

  List<NavigationPaneItem> get originalItems {
    return drawerMenus.map((item) {
      if (item.pages != null && item.pages!.isNotEmpty) {
        return PaneItemExpander(
          icon: item.icon ?? SizedBox.shrink(),
          title: Text(item.label),
          items: item.pages!.map((e) {
            return buildPane(e);
          }).toList(),
          body: item.body,
        );
      }
      return buildPane(item);
    }).toList();
  }

  PaneItem buildPane(ItemPage item) {
    return PaneItem(
      title: Text(item.label),
      body: BreadCrumb(itemInitial: item, pages: pagesNavigator),
      icon: item.icon ?? SizedBox.shrink(),
      onTap: () {
        setState(() {
          _selectedIndex = pagesNavigator.indexWhere(
            (element) => element.route == item.route,
          );
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            item.route,
            (Route<dynamic> route) => false,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        actions: WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(child: MoveWindow()),
              const WindowButtons(),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        size: const NavigationPaneSize(openMaxWidth: 230),
        indicator: const EndNavigationIndicator(),
        selected: _selectedIndex,
        header: widget.header == null
            ? null
            : PageHeader(
                title: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: widget.header!,
                ),
              ),
        toggleable: true,
        items: [...originalItems],
        footerItems: [
          if (widget.footer != null) PaneItemHeader(header: widget.footer!),
        ],
      ),
    );
  }
}
