import 'package:flutter/material.dart';

import 'package:product_firebase/src/models/product_model.dart';

import 'package:product_firebase/src/bloc/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    

    final productsBloc = Provider.productsBloc(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _createListProduct(productsBloc),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createListProduct(ProductsBloc productsBloc) {

    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        
        if ( snapshot.hasData ) {

          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _createItem(context, productsBloc, products[i]),
          );
        } else {
          return Center( child: CircularProgressIndicator(), );
        }
      },
    );
  }

  Widget _createItem(BuildContext context, ProductsBloc productsBloc,ProductModel product) {
    
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ) => productsBloc.deleteProduct(product.id),
      child: Card(
        child: Column(
          children: <Widget>[
            
            ( product.photoUrl == null)
              ? Image( image: AssetImage('assets/images/no-image.png'), )
              : FadeInImage(
                image: NetworkImage( product.photoUrl ),
                placeholder: AssetImage('assets/images/jar-loading-gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            
            ListTile(
              title: Text('${product.title} - ${product.value}'),
              subtitle: Text( product.id ),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: product),
            ),

          ],
        ),
      )
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}