import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dayoff/features/notes/domain/entities/note_entity.dart';
import 'package:dayoff/features/notes/domain/use_cases/get_notes_usecase.dart';
import 'package:dayoff/features/notes/domain/use_cases/delete_note_usecase.dart';
import 'package:dayoff/features/notes/domain/use_cases/update_note_usecase.dart';
import 'package:dayoff/features/notes/domain/use_cases/add_new_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNotesUseCase getNotesUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  NoteCubit(
      {required this.getNotesUseCase,
      required this.deleteNoteUseCase,
      required this.updateNoteUseCase,
      required this.addNewNoteUseCase})
      : super(
          NoteInitial(),
        );

  Future<void> addNote({required NoteEntity note}) async {
    print('ADD NOTE');
    print(note.uid);
    try {
      await addNewNoteUseCase.call(note);
    } on SocketException catch (e) {
      print('CAPTO ERROR 3');

      emit(NoteFailure(message: e.message));
    } on FirebaseException catch (e) {
      print('CAPTO ERROR 2');

      emit(NoteFailure(message: e.message.toString()));
    } catch (e) {
      print('CAPTO ERROR');
      emit(NoteFailure(message: e.toString()));
    }
    // catch (_) {
    //   emit(NoteFailure(message: 'Someting went wrong'));
    // }
  }

  Future<void> deleteNote({required NoteEntity note}) async {
    try {
      await deleteNoteUseCase.call(note);
    } on SocketException catch (e) {
      emit(NoteFailure(message: e.message));
    } on FirebaseException catch (e) {
      emit(NoteFailure(message: e.message.toString()));
    } catch (_) {
      emit(NoteFailure(message: 'Someting went wrong'));
    }
  }

  Future<void> updateNote({required NoteEntity note}) async {
    try {
      await updateNoteUseCase.call(note);
    } on SocketException catch (e) {
      emit(NoteFailure(message: e.message));
    } on FirebaseException catch (e) {
      emit(NoteFailure(message: e.message.toString()));
    } catch (_) {
      emit(NoteFailure(message: 'Someting went wrong'));
    }
  }

  Future<void> getNotes({required String uid}) async {
    print('HACE GET NOTES');
    emit(NoteLoading());
    try {
      getNotesUseCase.call(uid).listen((notes) {
        emit(NoteLoaded(notes: notes));
      });
    } on SocketException catch (e) {
      emit(NoteFailure(message: e.message));
    } on FirebaseException catch (e) {
      emit(NoteFailure(message: e.message.toString()));
    } catch (_) {
      emit(NoteFailure(message: 'Someting went wrong'));
    }
  }
}
