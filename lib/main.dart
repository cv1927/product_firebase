import 'package:flutter/material.dart';

import 'package:product_firebase/src/bloc/provider.dart';

import 'package:product_firebase/src/pages/home_page.dart';
import 'package:product_firebase/src/pages/login_page.dart';
import 'package:product_firebase/src/pages/producto_page.dart';
 
void main() => runApp(FormValidation());
 
class FormValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'producto' : (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}