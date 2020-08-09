import 'dart:convert';

class NoteForPost{
  String title ;
  String content;

  NoteForPost({this.title , this.content});

  Map<String , dynamic> toJson(){
    return ({
      "noteTitle" : title,
      "noteContent" : content
    });
  }
}