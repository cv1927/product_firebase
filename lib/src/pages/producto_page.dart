import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:product_firebase/src/providers/product_provider.dart';

import 'package:product_firebase/src/utils/utils.dart' as utils;

import 'package:product_firebase/src/models/product_model.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = new ProductProvider();

  ProductModel product = new ProductModel();
  bool _save = false;
  File photo;

  @override
  Widget build(BuildContext context) {

    final ProductModel prodData = ModalRoute.of(context).settings.arguments;

    if ( prodData != null ) {
      product = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _camera,
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
                _viewPhoto(),
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
      onPressed: (_save) ? null : _submit,
    );
  }

  void _submit() async {

    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    setState(() { _save = true; });

    if ( photo != null ) {
      product.photoUrl = await productProvider.uploadImage(photo);
    }

    if ( product.id == null ) {

      productProvider.createProduct(product);

    }  else {
      productProvider.updateProduct(product);
    }

    //setState(() { _save = false; });
    mostrarSnackBar('Registro Guardado');

    Navigator.pop(context);
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500 ),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _viewPhoto() {
    if ( product.photoUrl != null ) {

      return FadeInImage(
        image: NetworkImage(product.photoUrl),
        placeholder: AssetImage('assets/jar-loading-gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {

      return Image(
        image: AssetImage( photo?.path ?? 'assets/image/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );

    }
  }

  _selectPhoto() async {

    _processImage(ImageSource.gallery);

  }

  _camera() async {

    _processImage(ImageSource.camera);
  }

  _processImage(ImageSource origin) async {

    photo = await ImagePicker.pickImage(
      source: origin
    );

    if ( photo != null ) {
      product.photoUrl = null;
    }

    setState(() {});
  }
}