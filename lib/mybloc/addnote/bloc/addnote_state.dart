part of 'addnote_bloc.dart';

@immutable
abstract class AddnoteState {}

class AddnoteInitial extends AddnoteState {
  
}

class AddnoteFailed extends AddnoteState{
  final String validation;

  AddnoteFailed(this.validation);
}

class AddnoteSucceed extends AddnoteState{
  
}

