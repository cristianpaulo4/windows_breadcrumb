import 'package:fluent_ui/fluent_ui.dart';

import 'package:windows_breadcrumb/src/widget/bar_windows.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BreadCrumbAppBar extends StatelessWidget {
  const BreadCrumbAppBar({super.key, this.actions});
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(child: MoveWindow()),
          WindowButtons(actions: actions),
        ],
      ),
    );
  }
}
