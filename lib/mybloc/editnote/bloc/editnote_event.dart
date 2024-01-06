part of 'editnote_bloc.dart';

@immutable
abstract class EditnoteEvent {}

class Editnote extends EditnoteEvent{
  final int? id;

  Editnote({required this.id});
}
