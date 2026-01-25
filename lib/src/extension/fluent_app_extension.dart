import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/src/entity/item_page.dart';

extension FluentAppExtension on FluentApp {
  static List<ItemPage> pages = [];

  void breadcrumbRoutes(List<ItemPage> itemPages) {
    pages = itemPages;
  }
}

class ClassName extends FluentApp {
  void printerRountes() {
    print(super.routes);
  }
}
