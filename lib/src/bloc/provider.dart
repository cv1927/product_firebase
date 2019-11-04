import 'package:flutter/material.dart';

import 'package:product_firebase/src/bloc/login_bloc.dart';
export 'package:product_firebase/src/bloc/login_bloc.dart';

import 'package:product_firebase/src/bloc/products_bloc.dart';
export 'package:product_firebase/src/bloc/products_bloc.dart';

class Provider extends InheritedWidget{

  final loginBloc     = new LoginBloc();
  final _productsBloc = new ProductsBloc();

  static Provider _instance;

  factory Provider({ Key key, Widget child }) {

    if ( _instance == null ) {
      _instance = new Provider._internal(key: key, child: child,);
    }

    return _instance;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child);

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child);

  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc;
  }

  static ProductsBloc productsBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._productsBloc;
  }

}