import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.loginGoogleIsSuccess,
      this.loginFacebookIsSuccess,
      this.userCredential});
  final UserCredential? userCredential;
  final bool? loginGoogleIsSuccess;
  final bool? loginFacebookIsSuccess;

  LoginState copyWith({
    bool? loginGoogleIsSuccess,
    bool? loginFacebookIsSuccess,
    UserCredential? userCredential,
  }) {
    return LoginState(
      loginGoogleIsSuccess: loginGoogleIsSuccess ?? this.loginGoogleIsSuccess,
      loginFacebookIsSuccess:
          loginFacebookIsSuccess ?? this.loginFacebookIsSuccess,
      userCredential: userCredential ?? this.userCredential,
    );
  }

  @override
  List<Object?> get props => [
        loginGoogleIsSuccess,
        loginFacebookIsSuccess,
        userCredential,
      ];
}
