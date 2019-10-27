import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productoModelToJson(ProductModel data) => json.encode(data.toString());

class ProductModel {
  String id;
  String title;
  double value;
  bool state;
  String photoUrl;

  ProductModel({
    this.id,
    this.title = '',
    this.value = 0.0,
    this.state = true,
    this.photoUrl
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => new ProductModel(
    id        : json['id'],
    title     : json['title'],
    value     : json['value'],
    state     : json['state'],
    photoUrl  : json['photoUrl']
  );

  Map<String, dynamic> toJson() => {
    // "id"        : id,
    "title"     : title,
    "value"     : value,
    "state"     : state,
    "photoUrl"  : photoUrl
  };
}