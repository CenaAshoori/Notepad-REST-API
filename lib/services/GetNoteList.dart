import 'dart:convert';

import 'package:notepad/moudle/note_item.dart';
import 'package:http/http.dart' as http;
import 'package:notepad/services/ApiResponse.dart';

class GetNoteList {
  String key;
  static const API = "http://api.notes.programmingaddict.com";
  var headers = {
    "apiKey": "03f53b59-b30d-400b-82c2-595492e9f27d",
  };

  getKey() async {
    print("request Sent");
    var res = await http.get(API + "/apiKey");
    print(res.statusCode);
    this.key = json.decode(res.body)["apiKey"];
    headers = {
      "apiKey": "03f53b59-b30d-400b-82c2-595492e9f27d",
    };
    print("fuck");

  }

  GetNoteList() {
    getKey();
  }

  Future<ApiResponse<List<NoteItem>>> getNoteList() async {
    return http.get(API + '/notes', headers: headers).then((data) {
      print(data);
      if (data.statusCode == 200) {
        final noteList = json.decode(data.body);
        final notes = <NoteItem>[];
        for (var item in noteList) {
          final note = NoteItem(
              item["noteID"],
              item["noteTitle"],
              DateTime.parse(item["createDateTime"]),
              item["latestEditDateTime"] != null
                  ? DateTime.parse(item["latestEditDateTime"])
                  : null);
          notes.add(note);
        }

        return ApiResponse<List<NoteItem>>(data: notes);
      }
      return ApiResponse<List<NoteItem>>(error: true);
    }).catchError((_) =>
        ApiResponse<List<NoteItem>>(error: true, message: "Error Get notes"));
  }
}
