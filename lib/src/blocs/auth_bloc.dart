import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:boilerplate_flutter/src/blocs/validators.dart';

class AuthBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordConfirmController = BehaviorSubject<String>();

  // Recuperar dados do Stream

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateQuantity);

  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validateQuantity);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get passwordConfirmStream =>
      _passwordConfirmController.stream.transform(validatePassword);

  Stream<bool> get loginValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Stream<bool> get signupValidStream => Observable.combineLatest4(nameStream,
      lastNameStream, emailStream, passwordStream, (n, l, e, p) => true);

  // Inserir valores ao Stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePasswordConfirm =>
      _passwordConfirmController.sink.add;

  // Obter o ultimo valor ingressado aos Streams
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get passwordConfirm => _passwordConfirmController.value;

  dispose() {
    _nameController?.close();
    _lastNameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmController?.close();
  }
}
