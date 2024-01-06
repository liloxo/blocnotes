import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providernotes/mybloc/getnotes/bloc/notes_bloc.dart';
import 'package:providernotes/view/editnote.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetNotes());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,centerTitle: true,title: const Text('Notes',style: TextStyle(letterSpacing: 1),),),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pushNamed(context, 'addnote',arguments: {'notes':BlocProvider.of<NotesBloc>(context).notesmodel});},backgroundColor: Colors.blueGrey,child: const Icon(Icons.add)),
      body: BlocBuilder<NotesBloc,NotesState>(
        builder: (context,state){
         if (state is NotesLoading){
          return const Center(child: Text('Loading'));
         }else if (state is NotesFetched){
            return ListView.builder(
              itemCount: state.notes!.length,
              itemBuilder: (context,i){
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      title: Text("${state.notes![i].title}"),
                      subtitle: Text("${state.notes![i].content}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         IconButton(
                          onPressed: ()async{
                           BlocProvider.of<NotesBloc>(context).add(DeleteNote(id: state.notes![i].id));
                          }, 
                          icon: const Icon(Icons.delete)
                           ),
                         IconButton(
                          onPressed: ()async{
                            Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  EditNote(
                              id: state.notes![i].id!,
                              title: state.notes![i].title!,
                              note: state.notes![i].content
                            ))));
                          }, 
                          icon: const Icon(Icons.edit)
                          )  
                        ],
                      )
                    ),
                  ),
                );
            });
         }else{
           return const Center(child: Text('Empty'));
         }
      }
      )
    );
  }
}
