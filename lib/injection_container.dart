
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dayoff/features/notes/presentation/cubit/note_cubit.dart';
import 'package:dayoff/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:dayoff/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:dayoff/features/auth/domain/use_cases/sign_out_usecase.dart';
import 'package:dayoff/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:dayoff/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:dayoff/features/notes/domain/use_cases/get_notes_usecase.dart';
import 'package:dayoff/features/notes/domain/use_cases/update_note_usecase.dart';
import 'package:dayoff/features/auth/domain/use_cases/is_signed_in_usecase.dart';
import 'package:dayoff/features/notes/domain/use_cases/delete_note_usecase.dart';
import 'package:dayoff/features/notes/domain/use_cases/add_new_note_usecase.dart';
import 'package:dayoff/features/auth/domain/use_cases/get_current_uid_usecase.dart';
import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';
import 'package:dayoff/features/notes/domain/repositories/notes_firebase_repository.dart';
import 'package:dayoff/features/auth/data/repositories/auth_firebase_repository_impl.dart';
import 'package:dayoff/features/notes/data/repositories/notes_firebase_repository_impl.dart';
import 'package:dayoff/features/auth/data/remote/data_sources/auth_firebase_remote_data_source.dart';
import 'package:dayoff/features/notes/data/remote/data_sources/notes_firebase_remote_data_source.dart';
import 'package:dayoff/features/auth/domain/use_cases/get_user_id_and_create_current_user_usecase.dart';
import 'package:dayoff/features/auth/data/remote/data_sources/auth_firebase_remote_data_source_impl.dart';
import 'package:dayoff/features/notes/data/remote/data_sources/notes_firebase_remote_data_source_impl.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Cubit/Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUPUseCase: sl.call(),
      ));
  sl.registerFactory<NoteCubit>(() => NoteCubit(
        updateNoteUseCase: sl.call(),
        getNotesUseCase: sl.call(),
        deleteNoteUseCase: sl.call(),
        addNewNoteUseCase: sl.call(),
      ));

  //USE CASES
  //useCase Auth
  sl.registerLazySingleton<GetUserIdAndCreateCurrentUser>(
      () => GetUserIdAndCreateCurrentUser(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignedInUseCase>(
      () => IsSignedInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUPUseCase>(
      () => SignUPUseCase(repository: sl.call()));

  //useCase Notes
  sl.registerLazySingleton<AddNewNoteUseCase>(
      () => AddNewNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetNotesUseCase>(
      () => GetNotesUseCase(repository: sl.call()));

  //repositories
  sl.registerLazySingleton<AuthFirebaseRepository>(
      () => AuthFirebaseRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<NotesFirebaseRepository>(
      () => NotesFirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //data sources
  sl.registerLazySingleton<AuthFirebaseRemoteDataSource>(() =>
      AuthFirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  sl.registerLazySingleton<NotesFirebaseRemoteDataSource>(() =>
      NotesFirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
