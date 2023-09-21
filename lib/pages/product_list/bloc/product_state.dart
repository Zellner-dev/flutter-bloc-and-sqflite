// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crud_bloc/model/product.dart';

abstract class ProductState {
  List<Product> products;

  ProductState({
    required this.products,
  });
}

class ProductInitialState extends ProductState {
  ProductInitialState({required super.products});
}

class ProductSuccessState extends ProductState {
  ProductSuccessState({required super.products});
}

class ProductLoadingState extends ProductState {
  ProductLoadingState({required super.products});
}

class ProductErroState extends ProductState {
  ProductErroState({required super.products});
}