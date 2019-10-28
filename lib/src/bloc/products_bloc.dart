import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:product_firebase/src/providers/product_provider.dart';

import 'package:product_firebase/src/models/product_model.dart';

class ProductsBloc {

  final _productsController = new BehaviorSubject<List<ProductModel>>();
  final _loadController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductProvider();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;
  Stream<bool> get loading => _loadController.stream;

  void loadProducts() async {

    final products = await _productsProvider.loadProducts();
    _productsController.sink.add(products);

  }

  void addProduct( ProductModel product ) async {
    
    _loadController.sink.add(true);
    await _productsProvider.createProduct(product);
    _loadController.sink.add(false);
  }

  Future<String> addPhoto( File photo ) async {
    
    _loadController.sink.add(true);
    final photoUrl = await _productsProvider.uploadImage(photo);
    _loadController.sink.add(false);

    return photoUrl;
  }

  void editProduct( ProductModel product ) async {
    
    _loadController.sink.add(true);
    await _productsProvider.updateProduct(product);
    _loadController.sink.add(false);
  }

  void deleteProduct( String id ) async {
    
    await _productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsController?.close();
    _loadController?.close();
  }

}