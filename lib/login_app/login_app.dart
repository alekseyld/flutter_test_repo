import 'package:bloctestapp/login_app/page/home_page.dart';
import 'package:bloctestapp/login_app/page/login_page.dart';
import 'package:bloctestapp/login_app/page/splash_page.dart';
import 'package:bloctestapp/login_app/repository/user_repository.dart';
import 'package:bloctestapp/login_app/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void startLoginApp() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    RepositoryProvider<UserRepository>(
      create: (context) => UserRepository(),
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context)
          )
            ..add(AuthenticationStarted());
        },
        child: LoginApp(),
      ),
    )
  );
}

class LoginApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashPage();
          }
          if (state is AuthenticationSuccess) {
            return HomePage();
          }
          if (state is AuthenticationFailure) {
            return LoginPage();
          }
          if (state is AuthenticationInProgress) {
            return LoadingIndicator();
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}