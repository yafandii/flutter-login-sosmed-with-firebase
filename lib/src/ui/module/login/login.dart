import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_sosmed/res.dart';
import 'package:flutter_login_sosmed/src/ui/module/detail/detail.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_bloc.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_event.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_state.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
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
                ButtonSosmed(
                  onPressed: () {
                    _bloc.add(LoginWithGoogle());
                  },
                  icon: AssetIcon.icGoogle,
                  label: "Login with Google",
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 10),
                ButtonSosmed(
                  onPressed: () {
                    _bloc.add(LoginWithFacebook());
                  },
                  icon: AssetIcon.icFacebook,
                  label: "Login with Facebook",
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ButtonSosmed extends StatelessWidget {
  const ButtonSosmed({
    super.key,
    this.onPressed,
    this.icon,
    this.label,
    this.backgroundColor,
    this.textColor,
  });

  final VoidCallback? onPressed;
  final String? icon;
  final String? label;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon ?? AssetIcon.icGoogle,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label ?? '',
              style: TextStyle(
                color: textColor ?? Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
