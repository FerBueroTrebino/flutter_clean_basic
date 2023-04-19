part of 'auth_cubit.dart';

abstract class AuthStateCustom extends Equatable {
  const AuthStateCustom();
}

class AuthInitial extends AuthStateCustom {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthStateCustom {
  final String uid;

  const Authenticated({required this.uid});
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthStateCustom {
  @override
  List<Object> get props => [];
}