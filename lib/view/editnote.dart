import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/textfield.dart';
import '../homepage.dart';
import '../mybloc/editnote/bloc/editnote_bloc.dart';

class EditNote extends StatefulWidget {
  final String title;
  final int id;
  final String? note;
  const EditNote({Key? key, required this.title, this.note, required this.id}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  void initState() {
    BlocProvider.of<EditnoteBloc>(context).title = TextEditingController(text: widget.title);
    BlocProvider.of<EditnoteBloc>(context).content = TextEditingController(text: widget.note);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const Text("Edit Note",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
      ),
      body: BlocListener<EditnoteBloc,EditnoteState>(
        listener: (context, state) {
        if(state is EditnoteSucceed){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyHomePage()), (route) => false);
          }else if (state is EditnoteFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.validation)));
          }
      },
      child: Form(
        key: BlocProvider.of<EditnoteBloc>(context).formkey,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Textfield(hintxt:"Enter a title",controller:BlocProvider.of<EditnoteBloc>(context).title , validator: 
                (val){
                  if(val!.isEmpty){
                    return 'Field is empty';
                  }
                  return null;
                  } )
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Textfield(hintxt:"Enter a note",controller: BlocProvider.of<EditnoteBloc>(context).content)
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: MaterialButton(
                color: Colors.blueGrey,
                child: const Text("Edit Note",style: TextStyle(color: Colors.white,fontSize: 17),),
                onPressed: ()async{
                 BlocProvider.of<EditnoteBloc>(context).add(Editnote(id: widget.id));
                }
                ),
            )
          ],
        ),
      ),
      )
    );
  }
}