import 'package:flutter/foundation.dart';
import 'package:paginate_app/paginator.dart';

import 'product.dart';

class ProductController extends ChangeNotifier {
  final _productPaginator = Paginator<Product>();
  Paginator<Product> get productPaginator => _productPaginator;

  Future<bool> fetchProduct() async {
    // This section should be replaced by web service call
    // This is just demo api call.
    await Future.delayed(const Duration(seconds: 3), () {});

    if (_productPaginator.hasNextPage) {
      final start =
          _productPaginator.pageIndex * _productPaginator.perPageItems;
      final end = start + _productPaginator.perPageItems;

      final fetchedProducts = productsFromServer.getRange(start, end).toList();
      final hasNextPage = _productPaginator.items.length <
          (productsFromServer.length - _productPaginator.perPageItems);
      _productPaginator.addItems(fetchedProducts, hasNextPage);
    }
    return true;
  }
}
