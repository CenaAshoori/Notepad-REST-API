import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notepad/moudle/NoteForPost.dart';
import 'package:notepad/moudle/note_item.dart';
import 'package:notepad/pages/note_list.dart';
import 'package:notepad/services/GetNoteList.dart';

class NoteModify extends StatefulWidget {
  final String noteID;

  NoteModify({
    this.noteID,
  });

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  final service = GetIt.I<GetNoteList>();
  bool _isLoading = false;
  String errMassage;
  NoteItem noteItem;

  TextEditingController _controler_title = TextEditingController();
  TextEditingController _contorler_body = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.noteID != null) {
      setState(() {
        _isLoading = true;
      });
      service.getNote(widget.noteID).then((data) {
        if (data.error) {
          errMassage = data.message ?? "error has occurred";
        }
        noteItem = data.data;
        _controler_title.text = noteItem.title;
        _contorler_body.text = noteItem.noteContent;
        print(_contorler_body.text);

        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoading ? "Add Note" : "Editing note"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _controler_title,
                      decoration: InputDecoration(
                          hintText: "Enter title", labelText: "Title"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _contorler_body,
                      decoration: InputDecoration(
                          labelText: "Subject", hintText: "Enter subjet"),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Submit"),
                        onPressed: () async {
                          final result = await service.createNote(NoteForPost(
                              title: _controler_title.text,
                              content: _contorler_body.text));
                          final text = result.error
                              ? "an error has occurred"
                              : "note is created";
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text("Done"),
                                    content: Text(text),
                                    actions: <Widget>[
                                      RaisedButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )).then((value) => Navigator.of(context).pop(MaterialPageRoute(builder: (_)=>NoteList())));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
