import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dayoff/features/auth/domain/entities/user_entity.dart';
import 'package:dayoff/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:dayoff/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:dayoff/features/auth/domain/use_cases/get_user_id_and_create_current_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUPUseCase signUPUseCase;
  final GetUserIdAndCreateCurrentUser getCreateCurrentUserUseCase;
  UserCubit(
      {required this.signUPUseCase,
      required this.signInUseCase,
      required this.getCreateCurrentUserUseCase})
      : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (e) {
      emit(UserFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      emit(UserFailure(message: e.message.toString()));
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUPUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (e) {
      emit(UserFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      emit(UserFailure(message: e.message.toString()));
    }
  }

  Future<void> registerOAuthUser({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await getCreateCurrentUserUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (e) {
      emit(UserFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      emit(UserFailure(message: e.message.toString()));
    }
  }
}
