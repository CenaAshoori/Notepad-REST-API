import 'package:flutter/cupertino.dart';

class NoteItem {
  String noteID;
  String title;
  DateTime createTime;
  DateTime lastEdite;

  NoteItem(
    this.noteID,
    this.title,
    this.createTime,
    this.lastEdite,
  );
  String formatDateTime(){
//    return "${this.lastEdite.day}/${this.lastEdite.month}/${this.lastEdite.year}";
    return "${createTime}";
  }
}
