import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';
import 'package:notepad/moudle/note_for_listing.dart';
import 'package:notepad/pages/delete_alert.dart';
import 'package:notepad/pages/NoteModifyView.dart';
import 'package:notepad/services/ApiResponse.dart';
import 'package:notepad/services/NoteListService.dart';

class NoteListView extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteListView> {
  ApiResponse<List<NoteForListing>> _apiResponse;

  NoteListService get service => GetIt.I<NoteListService>();
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NoteModifyView()))
                  .then((value) {
                _fetchData();
                print("float Btn is Pressed");
              });
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
              return Center(
                child: Text("an Error Has ucorrd"),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(
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
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (_) => NoteListView()));
                    }
                    return result;
                  },
                  onDismissed: (direction) {
                    service.deleteNote(_apiResponse.data[index].noteID);

                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (_) => NoteModifyView(
                                  noteID: _apiResponse.data[index].noteID)))
                          .then((value) => _fetchData());
                    },
                    title: Text(
                      _apiResponse.data[index].title,
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
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
