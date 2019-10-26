import 'package:flutter/material.dart';

import 'package:product_firebase/src/providers/product_provider.dart';

import 'package:product_firebase/src/utils/utils.dart' as utils;

import 'package:product_firebase/src/models/product_model.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final productProvider = new ProductProvider();

  ProductModel product = new ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _createName(),
                _createPrice(),
                _createAvailable(),
                _createButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => product.title = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'El nombre debe ser más largo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => product.value = double.parse(value),
      validator: (value) {

        if ( utils.isNumeric(value) ) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
    );
  }

  Widget _createAvailable() {

    return SwitchListTile(
      value: product.state,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        product.state = value;
      }),
    );

  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: _submit,
    );
  }

  void _submit() {

    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    productProvider.createProduct(product);

  }
}