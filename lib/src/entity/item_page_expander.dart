import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class ItemPageExpandend extends ItemPage {
  final String label;
  final Widget icon;
  final List<ItemPage> pages;

  ItemPageExpandend({
    required this.label,
    required this.icon,
    required this.pages,
  }) : super(
         label: label,
         icon: icon,
         pages: pages,
         isDrawer: true,
         body: const SizedBox.shrink(),
         route: '',
       );
}
