import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class ItemPageButton extends ItemPage {
  final Function() onPressed;

  ItemPageButton({
    required this.onPressed,
    required super.label,
    super.icon,
    super.isDrawer = true,
  });
}
