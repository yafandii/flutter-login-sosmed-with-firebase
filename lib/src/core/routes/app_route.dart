import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_sosmed/src/ui/module/detail/detail.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_bloc.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => LoginBloc(),
            child: const LoginScreen(),
          ),
        );

      case DetailUSer.routeName:
        final data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => DetailUSer(user: data as User),
        );

      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => const Scaffold(
            body: Center(
              child: Text(
                'Page Not Found',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
    }
  }
}
