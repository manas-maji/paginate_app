import 'package:flutter/material.dart';
import 'package:paginate_app/product_controller.dart';
import 'package:paginate_app/product_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
      ],
      child: MaterialApp(
        title: 'Pagination Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
