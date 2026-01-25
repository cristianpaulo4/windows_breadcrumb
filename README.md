import 'package:example/category/category_page.dart';
import 'package:example/home/home_page.dart';
import 'package:example/page2/page2.dart';
import 'package:example/product/product_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_breadcrumb/windows_breadcrumb.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List<ItemPage> get pages => [
    ItemPage(
      label: 'Home',
      route: '/home',
      body: const HomePage(),
      icon: const Icon(FluentIcons.home),
      isDrawer: true,
    ),
    ItemPageExpandend(
      label: 'Cadastros 2',
      icon: const Icon(FluentIcons.pro_football),
      pages: [
        ItemPage(
          label: 'Produtos',
          route: '/product',
          body: const ProductPage(),
          icon: const Icon(FluentIcons.arrow_tall_down_left),
        ),
        ItemPage(
          label: 'Categoria',
          route: '/category',
          body: const CategoryPage(),
          icon: const Icon(FluentIcons.arrow_tall_down_left),
        ),
        ItemPage(label: 'Page 2', route: '/page2', body: const Page2()),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BreadCrumbBody(pages: pages);
  }
}
