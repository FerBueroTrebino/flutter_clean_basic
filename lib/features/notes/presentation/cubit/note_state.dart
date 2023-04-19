part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteFailure extends NoteState {
  final String message;

  const NoteFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class NoteLoaded extends NoteState {
  final List<NoteEntity> notes;

  NoteLoaded({required this.notes});
  @override
  List<Object> get props => [notes];
}
