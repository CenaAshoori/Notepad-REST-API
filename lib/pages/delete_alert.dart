import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete this note"),
      content: Text("Are you sure to Delete it ?"),
      actions: <Widget>[
        RaisedButton(
          child: Text("Yes"),
          onPressed: (){
            Navigator.of(context).pop(true);
          },
        ),
        RaisedButton(
          child: Text("No"),
          onPressed: (){
            Navigator.of(context).pop(false);

          },
        ),
      ],

    );
  }
}
