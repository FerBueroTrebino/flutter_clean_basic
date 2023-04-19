import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';

class SignOutUseCase {
  final AuthFirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
