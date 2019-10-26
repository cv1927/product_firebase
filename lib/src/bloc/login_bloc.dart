
import 'dart:async';

import 'package:product_firebase/src/bloc/validators.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  // final _emailController      = StreamController<String>.broadcast();
  // final _passwordController   = StreamController<String>.broadcast();
  final _emailController      = BehaviorSubject<String>();
  final _passwordController   = BehaviorSubject<String>();

  //Recuperar los datos del stream
  Stream<String> get emailStream     => _emailController.stream.transform( validateEmail );
  Stream<String> get passwordStream  => _passwordController.stream.transform( validatePassword );

  Stream<bool> get formValidStream   => 
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al steam
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el ultimo valor ingresado a los stream
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}