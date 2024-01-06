import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:providernotes/homepage.dart';
import 'package:providernotes/sqldb.dart';
import 'package:providernotes/view/addnote.dart';
import 'mybloc/addnote/bloc/addnote_bloc.dart';
import 'mybloc/editnote/bloc/editnote_bloc.dart';
import 'mybloc/getnotes/bloc/notes_bloc.dart';

Box? box;

Future<Box> openhivebox(String boxname) async{
  if(!Hive.isBoxOpen(boxname)){
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxname);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  box = await openhivebox('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return MultiBlocProvider(
      providers: [
      BlocProvider(
      create: (_) => NotesBloc(SqlDb())),
      BlocProvider(
      create: (_) => AddnoteBloc(SqlDb())),
      BlocProvider(
      create: (_) => EditnoteBloc(SqlDb()))
      ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const MyHomePage(),
      routes: {
        'addnote': (context)=> const AddNote()
      },
    )
    );
  }
}

