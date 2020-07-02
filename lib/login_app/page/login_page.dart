import 'package:bloctestapp/login_app/bloc/auth/bloc.dart';
import 'package:bloctestapp/login_app/bloc/login/bloc.dart';
import 'package:bloctestapp/login_app/repository/user_repository.dart';
import 'package:bloctestapp/login_app/widget/login_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
