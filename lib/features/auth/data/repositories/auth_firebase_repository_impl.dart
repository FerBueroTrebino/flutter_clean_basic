import 'package:dayoff/features/auth/domain/entities/user_entity.dart';
import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';
import 'package:dayoff/features/auth/data/remote/data_sources/auth_firebase_remote_data_source.dart';

class AuthFirebaseRepositoryImpl extends AuthFirebaseRepository {
  final AuthFirebaseRemoteDataSource remoteDataSource;

  AuthFirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> getUserIdAndCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getUserIdAndCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Future<bool> isSignedIn() async => remoteDataSource.isSignedIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);
}
