part of 'editnote_bloc.dart';

@immutable
abstract class EditnoteState {}

class EditnoteInitial extends EditnoteState {
  
}

class EditnoteFailed extends EditnoteState{
  final String validation;

  EditnoteFailed(this.validation);
}

class EditnoteSucceed extends EditnoteState{
  
}
