import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sqldb.dart';

part 'editnote_event.dart';
part 'editnote_state.dart';

class EditnoteBloc extends Bloc<EditnoteEvent, EditnoteState> {
  final SqlDb sqlDb;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  EditnoteBloc(this.sqlDb) : super(EditnoteInitial()) {
    on<EditnoteEvent>((event, emit) async {
      if(event is Editnote){
        if(formkey.currentState!.validate()){
          int response = await sqlDb.updateData({'title':title.text,'note':content.text},"id = ${event.id}");
          title.clear();content.clear();
          if(response > 0 ){
            emit(EditnoteSucceed());
          }else{
            emit(EditnoteFailed('Failed'));
          }
        }else{
          emit(EditnoteFailed('Fields cant be empty'));
          
        }
      }
    });
  }
}
