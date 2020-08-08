import 'package:flutter/cupertino.dart';

class NoteForListing {
  String noteID;
  String title;
  DateTime createTime;
  DateTime lastEdite;

  NoteForListing(
    this.noteID,
    this.title,
    this.createTime,
    this.lastEdite,
  );

  factory NoteForListing.fromJson(Map<String , dynamic> item){
    return NoteForListing(
        item["noteID"],
        item["noteTitle"],
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
