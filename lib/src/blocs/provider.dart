import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/src/blocs/auth_bloc.dart';
export 'package:boilerplate_flutter/src/blocs/auth_bloc.dart';

class Provider extends InheritedWidget {
  final authBloc = AuthBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthBloc auth(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .authBloc;
  }
}
