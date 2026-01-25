import 'package:example/base/base_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:windows_breadcrumb/windows_breadcrumb.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(1200, 720);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        fontFamily: GoogleFonts.notoSans().fontFamily,
        buttonTheme: ButtonThemeData(
          filledButtonStyle: ButtonStyle(
            padding: WidgetStatePropertyAll(
              const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
            ),
          ),
          outlinedButtonStyle: ButtonStyle(
            padding: WidgetStatePropertyAll(
              const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
            ),
          ),
          defaultButtonStyle: ButtonStyle(
            padding: WidgetStatePropertyAll(
              const EdgeInsets.symmetric(vertical: 9),
            ),
          ),
        ),
      ),
      home: const BasePage(),
    );
  }
}
