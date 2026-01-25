import 'package:flutter/widgets.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class ItemDrawer extends ItemPage {
  final String label;
  final String route;
  final Widget icon;
  final Widget body;

  ItemDrawer({
    required this.label,
    required this.route,
    required this.icon,
    required this.body,
    List<ItemPage>? pages,
  }) : super(label: label, route: route, icon: icon, body: body, pages: pages);
}
