import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:product_firebase/src/models/product_model.dart';

class ProductProvider {

  final String _url = 'https://product-firebase-194b7.firebaseio.com';

  Future<bool> createProduct( ProductModel product ) async {

    final url = '$_url/products.json';

    final resp = await http.post( url, body: productoModelToJson(product) );

    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<bool> updateProduct( ProductModel product ) async {

    final url = '$_url/products/${product.id}.json';

    final resp = await http.put( url, body: productoModelToJson(product) );

    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<List<ProductModel>> loadProducts() async {

    final url = '$_url/products.json';

    final resp = await http.get( url );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = new List();

    if ( decodedData == null ) return [];

    decodedData.forEach( (id, prod) {
      
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);

    });

    return [];

  }

  Future<int> deleteProduct(String id) async {

    final url = '$_url/products>/$id.json';

    final resp = await http.delete(url);

    return 1;

  }


  Future<String> uploadImage( File image) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dkl5cw8wr/image/upload?upload_preset=oajtba1y');
    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(  mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      return null;
    }

    final respData = json.decode(resp.body);

    return respData['secure_url'];

  }

}