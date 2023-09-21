import 'package:bloc/bloc.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_event.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_state.dart';
import 'package:crud_bloc/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductRepository repository = ProductRepository();

  ProductBloc() :super(ProductInitialState(products: [])) {

    on<LoadProductEvent>(
      (event, emit) async {
        emit(ProductLoadingState(products: []));
        final list = await repository.get();
        if(list.isEmpty) {
          emit(ProductInitialState(products: []));
        }else {
          emit(ProductSuccessState(products: list));
        }
      },
    );  
    
    on<AddProductEvent>((event, emit) async {
      emit(ProductLoadingState(products: []));
      final list = await repository.add(event.data);
      emit(ProductSuccessState(products: list));
    });

    on<RemoveProductEvent>(
      (event, emit) async {
        final list =  await repository.remove(event.id);
        if(list.isEmpty) {
          emit(ProductInitialState(products: []));
        }else {
          emit(ProductSuccessState(products: list));
        }
      },
    );
  }
}