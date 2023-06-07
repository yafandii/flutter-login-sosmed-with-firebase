import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginEvent {}

class LoginWithGoogle extends LoginEvent {}

class LoginWithFacebook extends LoginEvent {}
