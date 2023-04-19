import 'package:dayoff/features/auth/domain/entities/user_entity.dart';

abstract class AuthFirebaseRepository {
  Future<bool> isSignedIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getUserIdAndCreateCurrentUser(UserEntity user);
}
