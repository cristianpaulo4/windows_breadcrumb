import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/src/widget/bar_windows.dart';
import 'package:windows_breadcrumb/src/widget/breadcrumb.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BreadCrumbBody extends StatefulWidget {
  const BreadCrumbBody({super.key, required this.pages});
  final List<ItemPage> pages;

  @override
  State<BreadCrumbBody> createState() => _BreadCrumbBodyState();
}

class _BreadCrumbBodyState extends State<BreadCrumbBody> {
  int _selectedIndex = 0;

  List<ItemDrawer> get drawerMenus {
    return widget.pages
        .where((e) => e.isDrawer)
        .map(
          (e) => ItemDrawer(
            label: e.label,
            route: e.route,
            icon: e.icon ?? const SizedBox.shrink(),
            body: e.body,
            pages: e.pages,
          ),
        )
        .toList();
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
          icon: item.icon,
          title: Text(item.label),
          items: item.pages!.map((e) {
            return PaneItem(
              title: Text(e.label),
              body: BreadCrumb(
                itemInitial: ItemDrawer(
                  label: e.label,
                  route: e.route,
                  icon: e.icon ?? const SizedBox.shrink(),
                  body: e.body,
                  pages: e.pages,
                ),
                pages: pagesNavigator,
              ),
              icon: e.icon ?? SizedBox(),
              onTap: () {
                setState(() {
                  _selectedIndex = pagesNavigator.indexWhere(
                    (element) => element.route == e.route,
                  );
                  navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    e.route,
                    (Route<dynamic> route) => false,
                  );
                });
              },
            );
          }).toList(),
          body: item.body,
        );
      }

      return PaneItem(
        title: Text(item.label),
        body: BreadCrumb(itemInitial: item, pages: pagesNavigator),
        icon: item.icon,
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
    }).toList();
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
        header: PageHeader(
          title: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: Text(
              "Exemplo BreadCrumb",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        toggleable: true,
        items: [...originalItems],
        footerItems: [
          PaneItemHeader(
            header: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "Versão ",
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
