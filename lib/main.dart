import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notepad/Constants/SharedData.dart';
import 'package:notepad/pages/NoteListView.dart';
import 'package:notepad/pages/NoteModifyView.dart';
import 'package:notepad/services/NoteListService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setuplocator() async {
  GetIt.I.registerLazySingleton(() => NoteListService());
  SharedData.key = await SharedPreferences.getInstance();
  SharedData.kiss = await SharedPreferences.getInstance();
  print(SharedData.key.get("key"));
  if (SharedData.kiss.getString("key") == null) {
    await GetIt.I<NoteListService>()
        .getKey()
        .then((value) => SharedData.key.setString("key", value));
  } else {
//    GetIt.I<NoteListService>().key = await SharedData.key.get("key");
    GetIt.I<NoteListService>().setKeybyMemory(await SharedData.key.get("key"));

    print("Have this key before");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setuplocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
