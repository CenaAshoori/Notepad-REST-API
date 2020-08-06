import 'package:flutter/material.dart';
import 'package:notepad/moudle/note_item.dart';

class NoteModify extends StatelessWidget {
  final NoteItem item;
  final _controler_title = TextEditingController();
  final _contorler_body = TextEditingController();

  NoteModify({this.item,})
  {
    if (item != null){
      _controler_title.text = item.noteID;
      _contorler_body.text = item.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? "Add Note" : item.noteID),
      ),
      body: Center(
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
                  onPressed: () {
                    Navigator.pop(context);
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
