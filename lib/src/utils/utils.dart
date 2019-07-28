import 'package:codefirst_progress_dialog/codefirst_progress_dialog.dart';
import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, String titulo, String mensagem) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      );
    },
  );
}

ProgressDialog pr;
var image = Image.asset('assets/spinner.gif');

void showProgressDialog(BuildContext context) {
  pr = new ProgressDialog(context, ProgressDialogType.Normal);
  pr.changeIcon(image);
  pr.setMessage('Aguarde...');
  pr.show();
}

void hideProgressDialog() {
  pr.hide();
}
