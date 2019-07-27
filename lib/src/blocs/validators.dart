import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('E-mail inválido');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('Mínimo de 6 caracteres');
      }
    },
  );

  // final validatePassword = StreamTransformer<String, String>.fromHandlers(
  //   handleData: (password, sink) {
  //     if (password.length >= 6 && password == passwordConfirm) {
  //       sink.add(password);
  //     } else {
  //       sink.addError('Mínimo de 6 caracteres');
  //     }
  //   },
  // );

  final validateQuantity = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length >= 2) {
        sink.add(value);
      } else {
        sink.addError('Mínimo de 2 caracteres');
      }
    },
  );

  final validateEquals = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length >= 2) {
        sink.add(value);
      } else {
        sink.addError('Mínimo de 2 caracteres');
      }
    },
  );
}
