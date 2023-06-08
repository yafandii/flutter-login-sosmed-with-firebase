import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_sosmed/src/ui/module/detail/detail.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_bloc.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_event.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_state.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _bloc;

  Future<String?> _getFacebookToken() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken = result.accessToken;
      return accessToken?.token;
    } else {
      return null;
    }
  }

  Future _handleFacebookSignIn() async {
    String? facebookAccessToken = await _getFacebookToken();

    debugPrint("facebookAccessToken = $facebookAccessToken");
    // loginToFirebase(accessToken: facebookAccessToken, isGoogle: false);
  }

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
                    onPressed: _handleFacebookSignIn,
                    child: const Text("Login with Facebook")),
              ],
            );
          },
        ),
      ),
    );
  }
}
