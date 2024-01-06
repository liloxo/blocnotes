import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providernotes/model/notemodel.dart';
import 'package:providernotes/sqldb.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  SqlDb sqlDb = SqlDb() ;
  List<NoteModel>? notesmodel = [];
  NotesBloc() : super(NotesInitial()) {
    on<NotesEvent>((event, emit) async {
      if(event is GetNotes){
        emit(NotesLoading());
        List prinotes = await sqlDb.readData();
        notesmodel = prinotes.map((e) => NoteModel.fromJson(e)).toList();
        if(notesmodel!.isNotEmpty){
         emit(NotesFetched(notes: notesmodel));
        }else{
          emit(NotesInitial());
        } 
      }else if (event is DeleteNote){
        int response = await sqlDb.deleteData("id = ${event.id}");
        if(response >0){
          notesmodel!.removeWhere((element) => element.id == event.id);
          emit(NotesFetched(notes: notesmodel));
        }
      }else{
        emit(NotesInitial());
      }
    });
  }
}
