import 'package:boilerplate_flutter/src/providers/user_provider.dart';
import 'package:boilerplate_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/src/blocs/provider.dart';

class SignupScreen extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.auth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _nameField(bloc),
          SizedBox(
            height: 16.0,
          ),
          _lastNameField(bloc),
          SizedBox(
            height: 16.0,
          ),
          _emailField(bloc),
          SizedBox(
            height: 16.0,
          ),
          _passwordField(bloc),
          // SizedBox(
          //   height: 16.0,
          // ),
          // _passwordConfirmField(bloc),
          SizedBox(
            height: 60.0,
          ),
          SizedBox(
            height: 45.0,
            child: _button(bloc, context),
          ),
        ],
      ),
    );
  }

  Widget _nameField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Nome',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeName,
        );
      },
    );
  }

  Widget _lastNameField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.lastNameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Sobrenome',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeLastName,
        );
      },
    );
  }

  Widget _emailField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'E-mail',
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
            errorText: snapshot.error,
          ),
          obscureText: true,
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  // Widget _passwordConfirmField(AuthBloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.passwordConfirmStream,
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       return TextField(
  //         decoration: InputDecoration(
  //           labelText: 'Confirmação de Senha',
  //           errorText: snapshot.error,
  //         ),
  //         obscureText: true,
  //         onChanged: bloc.changePasswordConfirm,
  //       );
  //     },
  //   );
  // }

  Widget _button(AuthBloc bloc, context) {
    return StreamBuilder(
      stream: bloc.signupValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Text(
            'Entrar',
            style: TextStyle(fontSize: 18.0),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
        );
      },
    );
  }

  _register(AuthBloc bloc, BuildContext context) async {
    showProgressDialog(context);
    Map info = await userProvider.createUser(
        bloc.name, bloc.lastName, bloc.email, bloc.password);

    hideProgressDialog();

    if (info['ok']) {
      Navigator.pushNamed(context, '/login');
      mostrarAlerta(context, 'Cadastro realizado.', info['message']);
    } else {
      mostrarAlerta(context, 'Erro ao cadastrar.', info['message']);
    }
  }
}
