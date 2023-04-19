import 'package:dayoff/features/notes/domain/entities/note_entity.dart';
import 'package:dayoff/features/notes/domain/repositories/notes_firebase_repository.dart';

class DeleteNoteUseCase {
  final NotesFirebaseRepository repository;

  DeleteNoteUseCase({required this.repository});

  Future<void> call(NoteEntity note) async {
    return repository.deleteNote(note);
  }
}
