import 'package:dayoff/features/auth/domain/entities/user_entity.dart';
import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';

class GetUserIdAndCreateCurrentUser {
  final AuthFirebaseRepository repository;

  GetUserIdAndCreateCurrentUser({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getUserIdAndCreateCurrentUser(user);
  }
}
