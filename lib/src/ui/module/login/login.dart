import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_sosmed/src/ui/module/detail/detail.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_bloc.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_event.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginGoogleIsSuccess == true) {
              Navigator.pushNamed(context, DetailUSer.routeName,
                  arguments: state.userCredential?.user);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(LoginWithGoogle());
                    },
                    child: const Text("Login with Google")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(LoginWithFacebook());
                    },
                    child: const Text("Login with Facebook")),
              ],
            );
          },
        ),
      ),
    );
  }
}
