class NoteModel {
  int? id;
  String? title;
  String? content;
  NoteModel({ this.id,required this.title,this.content});

  NoteModel.fromJson(Map<String , dynamic>? data){
    id = data!['id'];
    title = data['title'];
    content = data['note'];
  }
}