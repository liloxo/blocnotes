import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ; 
  
  Future<Database?> get db async {
    if (_db == null){
      _db  = await intialDb() ;
      return _db ;  
    }else {
      return _db ; 
    }
  }

intialDb() async {
  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'providernotes') ;   
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  ) ;  
  return mydb ; 
}

/*_onUpgrade(Database db , int oldversion , int newversion ) {

 print("onUpgrade =====================================") ; 
}*/

_onCreate(Database db , int version) async {
  await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''') ;
}

readData() async {
  Database? mydb = await db ; 
  List<Map> response = await  mydb!.query('notes');
  return response ; 
}
insertData(Map<String, Object?> values) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.insert('notes',values);
  return response ; 
}
updateData(Map<String, Object?> values,String mywhere) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.update('notes',values,where: mywhere);
  return response ; 
}
deleteData(String mywhere) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.delete('notes',where: mywhere);
  return response ; 
}
mydeletedb() async {
  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'providernotes') ;    
  await deleteDatabase(path);
}

}