// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ProductEvent {}

class LoadProductEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Map<String, dynamic> data;
  AddProductEvent(this.data);
}

class RemoveProductEvent extends ProductEvent {
  final int id;

  RemoveProductEvent(
    this.id,
  );
}
