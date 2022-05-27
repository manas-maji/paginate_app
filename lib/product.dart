class Product {
  final String name;
  final int price;

  Product(this.name, this.price);
}

final productsFromServer =
    List.generate(80, (i) => Product('Product ${i + 1}', (i + 1) * 10));
