import 'package:dayoff/features/auth/domain/repositories/auth_firebase_repository.dart';

class GetCurrentUidUseCase {
  final AuthFirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUId();
  }
}
