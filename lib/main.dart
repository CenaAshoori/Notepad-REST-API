import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notepad/pages/NoteListView.dart';
import 'package:notepad/pages/NoteModifyView.dart';
import 'package:notepad/services/NoteListService.dart';

void setuplocator () async{
  GetIt.I.registerLazySingleton(() => NoteListService());
  await GetIt.I<NoteListService>().getKey();
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
      home: NoteListView(),
//      home: NoteModify(),
    );
  }
}
