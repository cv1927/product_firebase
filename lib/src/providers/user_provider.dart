import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:product_firebase/src/preferences_user/preferences_user.dart';

class UserProvider {

  final String firebaseToken = 'AIzaSyAhMYh5JM-1MkPo3425B44Xf3wv8P_4uyc';
  final _prefs = new PreferencesUser();

  Future<Map<String,dynamic>> login( String email, String password ) async {
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true,
    };

    final resp = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    if ( decodedResp.containsKey('idToken') ) {
      // TODO: Salvar el token en el storage
      _prefs.token = decodedResp['idToken'];

      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'token': decodedResp['error']['message'] };
    }

  }

  Future<Map<String, dynamic>> newUser( String email, String password ) async {

    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true,
    };

    final resp = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    if ( decodedResp.containsKey('idToken') ) {
      // TODO: Salvar el token en el storage
      _prefs.token = decodedResp['idToken'];
      
      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'token': decodedResp['error']['message'] };
    }

  }
}