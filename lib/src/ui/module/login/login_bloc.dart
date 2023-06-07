import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_sosmed/src/core/repositories/auth_repositories.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_event.dart';
import 'package:flutter_login_sosmed/src/ui/module/login/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository? _authRepository;
  LoginBloc() : super(const LoginState()) {
    _authRepository = AuthRepository();
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<LoginWithFacebook>(_onLoginWithFacebook);
  }

  void _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<LoginState> emit) async {
    UserCredential? result;
    result = await _authRepository?.signInWithGoogle();
    emit(state.copyWith(
      loginGoogleIsSuccess: true,
      userCredential: result,
    ));
  }

  void _onLoginWithFacebook(
      LoginWithFacebook event, Emitter<LoginState> emit) async {
    String? tokenFacebook;
    tokenFacebook = await _authRepository?.signInWithFacebook();
    print('LoginWithFacebook token = $tokenFacebook');
  }
}
