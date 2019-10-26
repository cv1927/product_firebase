import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:product_firebase/src/models/product_model.dart';

class ProductProvider {

  final String _url = 'https://product-firebase-194b7.firebaseio.com';

  Future<bool> createProduct( ProductModel product ) async {

    final url = '$_url/products.json';

    final resp = await http.post( url, body: productoModelToJson(product) );

    final decodedData = json.decode(resp.body);

    return true;
  }

}