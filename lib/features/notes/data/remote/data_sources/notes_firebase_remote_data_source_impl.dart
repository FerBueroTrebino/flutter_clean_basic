import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dayoff/features/notes/domain/entities/note_entity.dart';
import 'package:dayoff/features/notes/data/remote/models/note_model.dart';
import 'package:dayoff/features/notes/data/remote/data_sources/notes_firebase_remote_data_source.dart';

class NotesFirebaseRemoteDataSourceImpl
    implements NotesFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  NotesFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<void> addNewNote(NoteEntity noteEntity) async {
    try {
      final noteCollectionRef =
          firestore.collection("users").doc(noteEntity.uid).collection("notes");

      final noteId = noteCollectionRef.doc().id;

      final noteref = await noteCollectionRef.doc(noteId).get();

      final newNote = NoteModel(
        uid: noteEntity.uid,
        noteId: noteId,
        note: noteEntity.note,
        time: noteEntity.time,
      ).toDocument();

      if (!noteref.exists) {
        noteCollectionRef.doc(noteId).set(newNote);
      }

      /*  noteCollectionRef.doc(noteId).get().then((note) {
        final newNote = NoteModel(
          uid: noteEntity.uid,
          noteId: noteId,
          note: noteEntity.note,
          time: noteEntity.time,
        ).toDocument();

        if (!note.exists) {
          noteCollectionRef
              .doc(noteId)
              .set(newNote)
              .catchError((error, stackTrace) {
            print('error');
            print(error);
            // throw error;
          });
        }
        return;
      }); */
    } catch (e) {
      print('CAPTA ERROR XXXXXXXXXX');

      ///TODO: TENGO QUE HACER UN MOCK SERVICE Y AHI TIRAR ERRORES
      ///
      /// SEGUIR ESTE EJEMPLO:
      /// https://betterprogramming.pub/functional-error-handling-in-flutter-ac6fcf8ae22b

      rethrow;
    }
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection("users").doc(noteEntity.uid).collection("notes");

    noteCollectionRef.doc(noteEntity.noteId).get().then((note) {
      if (note.exists) {
        noteCollectionRef.doc(noteEntity.noteId).delete();
      }
      return;
    });
  }

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollectionRef =
        firestore.collection("users").doc(uid).collection("notes");

    return noteCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => NoteModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    Map<String, dynamic> noteMap = Map();
    final noteCollectionRef =
        firestore.collection("users").doc(note.uid).collection("notes");

    if (note.note != null) noteMap['note'] = note.note;
    if (note.time != null) noteMap['time'] = note.time;

    noteCollectionRef.doc(note.noteId).update(noteMap);
  }
}
