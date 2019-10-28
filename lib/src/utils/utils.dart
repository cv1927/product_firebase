

import 'package:flutter/material.dart';

bool isNumeric( String value ) {
  if (value.isEmpty) return false;

  final number = num.tryParse(value);

  return ( number == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String message) {

  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );

}