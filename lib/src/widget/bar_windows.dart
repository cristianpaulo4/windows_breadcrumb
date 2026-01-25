import 'package:windows_breadcrumb/windows_breadcrumb.dart';
import 'package:fluent_ui/fluent_ui.dart';

final buttonColors = WindowButtonColors(
  iconNormal: const Color(0xFF805306),
  mouseOver: const Color(0xFFF6A00C),
  mouseDown: const Color(0xFF805306),
  iconMouseOver: const Color(0xFF805306),
  iconMouseDown: const Color(0xFFFFD500),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: const Color(0xFF805306),
  iconMouseOver: const Color(0xFF805306),
);

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: CommandBar(
            primaryItems: [
              CommandBarButton(
                icon: const WindowsIcon(WindowsIcons.mail),
                label: const Text('Dúvidas e Suporte'),
                tooltip: 'Enviar e-mail para dúvidas e suporte',
                onPressed: () {
                  ClassName().printerRountes();
                },
              ),
            ],
            overflowBehavior: CommandBarOverflowBehavior.wrap,
          ),
        ),
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
