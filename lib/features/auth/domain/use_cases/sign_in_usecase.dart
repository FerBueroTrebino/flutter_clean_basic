import 'package:dayoff/features/auth/domain/entities/user_entity.dart';
import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';

class SignInUseCase {
  final AuthFirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}
