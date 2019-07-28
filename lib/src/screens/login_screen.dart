import 'package:boilerplate_flutter/src/providers/user_provider.dart';
import 'package:boilerplate_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/src/blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.auth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Criar Conta',
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _emailField(bloc),
          SizedBox(
            height: 16.0,
          ),
          _passwordField(bloc),
          SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.right,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          SizedBox(
            height: 45.0,
            child: _button(bloc, context),
          ),
          SizedBox(
            height: 32.0,
          ),
        ],
      ),
    );
  }

  Widget _emailField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'E-mail',
            //counterText: snapshot.data,
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget _passwordField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Senha',
            //counterText: snapshot.data,
            errorText: snapshot.error,
          ),
          obscureText: true,
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget _button(AuthBloc bloc, context) {
    return StreamBuilder(
      stream: bloc.loginValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Text(
            'Entrar',
            style: TextStyle(fontSize: 18.0),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  _login(AuthBloc bloc, context) async {
    showProgressDialog(context);
    Map info = await userProvider.login(bloc.email, bloc.password);
    hideProgressDialog();

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      mostrarAlerta(context, 'Erro ao entrar', info['message']);
    }
  }
}
