import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pagination_view.dart';
import 'product.dart';
import 'product_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final Future<bool> _productsFuture;

  @override
  void initState() {
    super.initState();

    _productsFuture = context.read<ProductController>().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<bool>(
          future: _productsFuture,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final provider = context.read<ProductController>();
              return PaginationView<Product>(
                paginator: provider.productPaginator,
                itemBuilder: _buildItem,
                nextPageFetcher: provider.fetchProduct,
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildItem(Product product) {
    return ListTile(
      title: Text(product.name),
      trailing: Text(product.price.toString()),
    );
  }
}
