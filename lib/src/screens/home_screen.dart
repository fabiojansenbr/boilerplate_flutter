import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/src/blocs/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.auth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Text('Email ${bloc.email}'),
          Text('Password ${bloc.password}'),
        ],
      ),
    );
  }
}
