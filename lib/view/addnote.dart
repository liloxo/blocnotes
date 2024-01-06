import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providernotes/component/textfield.dart';
import '../homepage.dart';
import '../mybloc/addnote/bloc/addnote_bloc.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text("Add Note",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
      ),
      body: BlocListener<AddnoteBloc,AddnoteState>(
        listener: (context, state) {
          if(state is AddnoteSucceed){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyHomePage()), (route) => false);
          }else if (state is AddnoteFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.validation)));
          }
        },
        child: Form(
          key: BlocProvider.of<AddnoteBloc>(context).formkey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Textfield(hintxt:"Enter a title",controller:BlocProvider.of<AddnoteBloc>(context).title , validator: 
                (val){
                  if(val!.isEmpty){
                    return 'Field is empty';
                  }
                  return null;
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Textfield(hintxt:"Enter a note",controller: BlocProvider.of<AddnoteBloc>(context).content )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MaterialButton(
                  color: Colors.blueGrey,
                  child: const Text("Add Note",style: TextStyle(color: Colors.white,fontSize: 17),),
                  onPressed: ()async{
                    BlocProvider.of<AddnoteBloc>(context).add(Addnote());
                  }
                  )
              )
            ]
          ),
        )
      )
    );
  }
}