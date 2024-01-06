import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providernotes/sqldb.dart';
part 'addnote_event.dart';
part 'addnote_state.dart';

class AddnoteBloc extends Bloc<AddnoteEvent, AddnoteState> {
  final SqlDb sqlDb;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  AddnoteBloc(this.sqlDb) : super(AddnoteInitial()) {
    on<AddnoteEvent>((event, emit) async {
      if(event is Addnote){
        if(formkey.currentState!.validate()){
          int response = await sqlDb.insertData({'title':title.text,'note':content.text});
          title.clear();content.clear();
          if(response > 0 ){
            emit(AddnoteSucceed());
          }else{
            emit(AddnoteFailed('Failed'));
          }
        }else{
          emit(AddnoteFailed('Fields cant be empty'));
          
        }
      }
    });
  }
}
