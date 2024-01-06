part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesFetched extends NotesState {
  final List<NoteModel>? notes;

  NotesFetched({required this.notes});
}

 