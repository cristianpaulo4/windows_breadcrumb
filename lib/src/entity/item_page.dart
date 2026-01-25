import 'package:flutter/widgets.dart';

class ItemPage {
  final String label;
  final String route;
  final Widget body;
  final List<ItemPage>? pages;
  final Widget? icon;
  final bool isDrawer;
  ItemPage({
    required this.label,
    required this.route,
    required this.body,
    this.pages,
    this.icon,
    this.isDrawer = false,
  });
}
