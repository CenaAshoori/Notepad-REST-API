import 'package:flutter/cupertino.dart';

class NoteItem {

  String noteID;
  String title;
  String noteContent;
  DateTime createTime;
  DateTime lastEdite;

  NoteItem(
      this.noteID,
      this.title,
      this.noteContent,
      this.createTime,
      this.lastEdite,
      );
  factory NoteItem.fromJson(Map<String, dynamic> item){
    return NoteItem(
        item["noteID"],
        item["noteTitle"],
        item["noteContent"],
        DateTime.parse(item["createDateTime"]),
        item["latestEditDateTime"] != null
            ? DateTime.parse(item["latestEditDateTime"])
            : null);
  }
  String formatDateTime(){
//    return "${this.lastEdite.day}/${this.lastEdite.month}/${this.lastEdite.year}";
    return "${createTime}";
  }

}
