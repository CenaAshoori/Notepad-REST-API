import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';
import 'package:notepad/moudle/note_for_listing.dart';
import 'package:notepad/pages/delete_alert.dart';
import 'package:notepad/pages/note_modify.dart';
import 'package:notepad/services/ApiResponse.dart';
import 'package:notepad/services/GetNoteList.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  ApiResponse<List<NoteForListing>> _apiResponse;

  GetNoteList get service => GetIt.I<GetNoteList>();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNoteList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            onPressed: () {
              print(GetIt
                  .I<GetNoteList>()
                  .headers);
              _fetchData();
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (_) => NoteModify()));
              print("float Btn is Pressed");
            },
            icon: Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          title: Text("Note List"),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_apiResponse.error != null) {
              return Center(child: Text("an Error Has ucorrd"),);
            }
            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(
                    height: 2,
                    color: Colors.green,
                  ),
              itemBuilder: (_, index) {
                return Dismissible(
                  secondaryBackground: Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        child: Icon(Icons.star),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                  key: ValueKey(index),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    bool result = false;
                    if (direction == DismissDirection.startToEnd) {
                      result = await showDialog(
                          context: context, builder: (_) => DeleteAlert());
                    } else if (direction == DismissDirection.endToStart) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => NoteList()));
                    }
                    return result;
                  },
                  onDismissed: (direction) {},
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              NoteModify(noteID: _apiResponse.data[index].noteID)));
                    },
                    title: Text(
                      _apiResponse.data[index].title,
                      style: TextStyle(
                          fontSize: 16, color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                    subtitle: Text(_apiResponse.data[index].formatDateTime()),
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}
