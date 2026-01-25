import 'package:fluent_ui/fluent_ui.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Center(child: Text('Page 2: $arguments')),
    );
  }
}
