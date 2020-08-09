import 'dart:convert';

import 'package:notepad/moudle/NoteForPost.dart';
import 'package:notepad/moudle/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:notepad/moudle/note_item.dart';
import 'package:notepad/services/ApiResponse.dart';

class GetNoteList {
  String key;
  static const API = "http://api.notes.programmingaddict.com";
  var headers = {
    "apiKey": "03f53b59-b30d-400b-82c2-595492e9f27d",
    "Content-Type" : "application/json"
  };

  getKey() async {
//    print("request Sent");
//    var res = await http.get(API + "/apiKey");
//    print(res.statusCode);
//    this.key = json.decode(res.body)["apiKey"];
////    headers = {
////      "apiKey": "03f53b59-b30d-400b-82c2-595492e9f27d",
////    };
//    print("fuck");

  }

  GetNoteList() {
    getKey();
  }

  Future<ApiResponse<List<NoteForListing>>> getNoteList() async {
    return http.get(API + '/notes', headers: headers).then((data) {
      print(data);
      if (data.statusCode == 200) {
        final noteList = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in noteList) {
          notes.add(NoteForListing.fromJson(item));
        }

        return ApiResponse<List<NoteForListing>>(data: notes);
      }
      return ApiResponse<List<NoteForListing>>(error: true);
    }).catchError((_) =>
        ApiResponse<List<NoteForListing>>(error: true, message: "Error Get notes"));
  }

  Future<ApiResponse<NoteItem>> getNote(String noteId) async {
      print("getting note" );
    return http.get(API + '/notes/'+noteId, headers: headers).then((data) {
      print(data);
      if (data.statusCode == 200) {
        print("The data is recived");
        final item = json.decode(data.body);

        return ApiResponse<NoteItem>(data: NoteItem.fromJson(item) , error: false);
      }
      return ApiResponse<NoteItem>(error: true);
    }).catchError((_) =>
        ApiResponse<NoteItem>(error: true, message: "Error Get notes"));
  }

  Future<ApiResponse<bool>> createNote(NoteForPost item) async {
      print("getting note" );

    return http.post(API + '/notes', headers: headers , body: json.encode({"noteTitle":item.title , "noteContent":item.content})).then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        return ApiResponse<bool>(data: true , error: false);
      }
      return ApiResponse<bool>(error: true);
    }).catchError((_) =>
        ApiResponse<bool>(error: true, message: "Error Get notes"));
  }
}
