import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notepad/pages/note_list.dart';
import 'package:notepad/pages/note_modify.dart';
import 'package:notepad/services/GetNoteList.dart';

void setuplocator () async{
  GetIt.I.registerLazySingleton(() => GetNoteList());
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setuplocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoteList(),
//      home: NoteModify(),
    );
  }
}
