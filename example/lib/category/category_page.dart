import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return ScaffoldPage(
      header: PageHeader(),
      content: Center(
        child: Column(
          children: [
            Text("Category"),
            Text("$arguments"),
            Button(
              onPressed: () {
                Navigator.of(context).pushNamed('/page2', arguments: 'test');
              },
              child: Text("Page 2"),
            ),
          ],
        ),
      ),
    );
  }
}
