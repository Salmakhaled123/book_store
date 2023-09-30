part of 'login_register_cubit.dart';

@immutable
abstract class LoginRegisterState {}

class LoginRegisterInitial extends LoginRegisterState {}
class LoginRegisterLoading extends LoginRegisterState {}
class LoginRegisterSuccess extends LoginRegisterState {}
class LoginRegisterFailure extends LoginRegisterState {}
class LoginLoading extends LoginRegisterState {}
class LoginSuccess extends LoginRegisterState {}
class LoginFailure extends LoginRegisterState {}
class CheckVisibility extends LoginRegisterState{}
class VerifiedSuccessfully extends LoginRegisterState {}
class VerifiedFailed extends LoginRegisterState {}
class ChangeIndexSuccess extends LoginRegisterState {}

