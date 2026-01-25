import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Button(
          onPressed: () {
            Navigator.of(
              context,
            ).navigateTo('/category', arguments: 'Enviado para categoria');
          },
          child: Text("Category"),
        ),
      ),
    );
  }
}
