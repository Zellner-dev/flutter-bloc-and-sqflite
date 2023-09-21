import 'dart:math';

import 'package:crud_bloc/database/database.dart';
import 'package:crud_bloc/model/product.dart';

class ProductRepository {

  final String _table = "PRODUCTS";
  final DatabaseService _database = DatabaseService();
  List<Product> _products = [];

  Future<List<Product>> add(Map<String, dynamic> data) async {

    final product = Product(
      id: Random().nextInt(99999), 
      name: data["nome"], 
      description: data["descricao"], 
      price: double.parse(data["preco"])
    );

    await _database.insert(_table, product.toMap());

    _products.add(product);

    return _products;
  }

  Future<List<Product>> get() async {
    final response = await _database.select(_table);
    _products = response.map((product) => Product.fromMap(product)).toList();
    return _products;
  }

  Future<List<Product>> remove(int id) async {
    _products.removeWhere((product) => product.id == id);
    _database.deleteById(_table, where: "ID = ?", whereArgs: [id]);
    return _products;
  }
}