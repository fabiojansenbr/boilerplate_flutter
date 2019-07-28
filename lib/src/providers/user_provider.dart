import 'dart:convert';

import 'package:boilerplate_flutter/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final userData = {'email': email, 'password': password};

    final resp = await http.post(
      'https://codefirst.herokuapp.com/api/v1/auth',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsValue('User not found')) {
      return {'ok': false, 'message': 'Usuário não encontrado'};
    }

    if (decodedResp.containsValue('Invalid password')) {
      return {'ok': false, 'message': 'Usuário ou Senha inválidos'};
    }

    if (decodedResp.containsValue(true)) {
      _prefs.token = decodedResp['token'];
      _prefs.name = decodedResp['name'];
      return {'ok': true, 'message': decodedResp['message']};
    } else {
      return {'ok': false, 'message': 'Erro de login. Favor contactar a TI.'};
    }
  }

  Future<Map<String, dynamic>> createUser(
      String name, String lastName, String email, String password) async {
    final userData = {
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password
    };

    final resp = await http.post(
      'https://codefirst.herokuapp.com/api/v1/users',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsValue('Email already exists')) {
      return {'ok': false, 'message': 'Este e-mail já está em uso.'};
    }

    if (decodedResp.containsValue(true)) {
      return {'ok': true, 'message': 'Usuário cadastrado com sucesso.'};
    } else {
      return {'ok': false, 'message': decodedResp['error']};
    }
  }
}
