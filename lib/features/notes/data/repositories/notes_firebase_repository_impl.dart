import 'package:dayoff/features/notes/domain/entities/note_entity.dart';
import 'package:dayoff/features/notes/domain/repositories/notes_firebase_repository.dart';
import 'package:dayoff/features/notes/data/remote/data_sources/notes_firebase_remote_data_source.dart';

class NotesFirebaseRepositoryImpl extends NotesFirebaseRepository {
  final NotesFirebaseRemoteDataSource remoteDataSource;

  NotesFirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> addNewNote(NoteEntity note) async =>
      remoteDataSource.addNewNote(note);

  @override
  Future<void> deleteNote(NoteEntity note) async =>
      remoteDataSource.deleteNote(note);

  @override
  Stream<List<NoteEntity>> getNotes(String uid) => 
      remoteDataSource.getNotes(uid);

  @override
  Future<void> updateNote(NoteEntity note) async =>
      remoteDataSource.updateNote(note);
}
