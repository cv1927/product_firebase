import 'package:flutter/material.dart';

import 'package:product_firebase/src/bloc/provider.dart';

import 'package:product_firebase/src/preferences_user/preferences_user.dart';

import 'package:product_firebase/src/pages/home_page.dart';
import 'package:product_firebase/src/pages/login_page.dart';
import 'package:product_firebase/src/pages/producto_page.dart';
import 'package:product_firebase/src/pages/registry_page.dart';
 
void main() async {

  final prefs = new PreferencesUser();
  await prefs.initPrefs();

  runApp(FormValidation());
}
 
class FormValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferencesUser();
    print( prefs.token );
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        initialRoute: 'login',
        routes: {
          'login'     : (BuildContext context) => LoginPage(),
          'registry'  : (BuildContext context) => RegistryPage(),
          'home'      : (BuildContext context) => HomePage(),
          'producto'  : (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}