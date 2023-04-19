import 'package:dayoff/features/notes/domain/entities/note_entity.dart';
import 'package:dayoff/features/notes/domain/repositories/notes_firebase_repository.dart';

class GetNotesUseCase {
  final NotesFirebaseRepository repository;

  GetNotesUseCase({required this.repository});

  Stream<List<NoteEntity>> call(String uid) {
    return repository.getNotes(uid);
  }
}
