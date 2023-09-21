import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_bloc.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_event.dart';
import 'package:crud_bloc/pages/product_list/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductForm extends StatelessWidget {

  final ProductBloc productsBloc;

  ProductForm({super.key, required this.productsBloc});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};


  void _submit() {
    if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    productsBloc.add(AddProductEvent(_formData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        backgroundColor: Colors.purple[100],
        actions: [
          IconButton(
            onPressed: _submit, 
            icon: const Icon(Icons.check_rounded)
          )
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState> (
        bloc: productsBloc,
        buildWhen: (previous, current) {
          if(previous is ProductLoadingState && current is ProductSuccessState) {
            Navigator.pop(context);
          }
          return true;
        },
        builder: (context, state){
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Nome"),
                        onSaved: (nome) => _formData["nome"] = nome,
                        validator: (nome) {
                          if(nome == null || nome.isEmpty) {
                            return "O campo não pode ser vazio.";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Descrição"),
                        onSaved: (descricao) => _formData["descricao"] = descricao,
                        validator: (descricao) {
                          if(descricao == null || descricao.isEmpty) {
                            return "O campo não pode ser vazio.";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Preço"),
                        keyboardType: TextInputType.number,
                        onSaved: (preco) => _formData["preco"] = preco,
                        validator: (preco) {
                          if(preco == null || preco.isEmpty) {
                            return "O campo não pode ser vazio.";
                          }
                          try{
                            double.parse(preco);
                          } catch (_) {
                            return "Preço inválido.";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if(state is ProductLoadingState)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.purple[100]),
                  ),
                )
            ],
          );
        }
      ),
    );
  }
}