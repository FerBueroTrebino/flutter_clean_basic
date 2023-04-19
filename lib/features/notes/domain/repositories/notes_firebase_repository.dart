import 'package:dayoff/features/notes/domain/entities/note_entity.dart';

abstract class NotesFirebaseRepository {
  Future<void> addNewNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
  Future<void> deleteNote(NoteEntity note);
  Stream<List<NoteEntity>> getNotes(String uid);
}
