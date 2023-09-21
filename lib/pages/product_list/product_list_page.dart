import 'package:crud_bloc/pages/product_form/product_form.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_bloc.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_event.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  late final ProductBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ProductBloc();
    bloc.add(LoadProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        backgroundColor: Colors.purple[100],
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductForm(productsBloc: bloc),
            )),
            icon: const Icon(Icons.add_rounded)
          )
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState> (
        bloc: bloc,
        builder: (context, state) {
          if(state is ProductInitialState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.air_rounded, 
                    color: Colors.black.withOpacity(0.6),
                    size: 70,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Seja bem vindo! Adicione produtos para que eles apareção aqui",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          }
          if(state is ProductLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.purple[100],),
            );
          }
          if(state is ProductSuccessState){
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  child: ListTile(
                    onLongPress: () {
                      bloc.add(RemoveProductEvent(product.id));
                    },
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(product.description),
                    trailing: Text(
                      "R\$${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("asdaosd"); 
        },
      ),
    );
  }
}