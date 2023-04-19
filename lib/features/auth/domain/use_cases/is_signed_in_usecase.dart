import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';

class IsSignedInUseCase {
  final AuthFirebaseRepository repository;

  IsSignedInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignedIn();
  }
}
