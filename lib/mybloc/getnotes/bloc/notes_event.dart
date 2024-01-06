part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class GetNotes extends NotesEvent{}

class DeleteNote extends NotesEvent{
  final int? id;

  DeleteNote({required this.id});
}
 