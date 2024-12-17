import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/services/shred_preference.dart';
import 'package:note_app/src/app_root.dart';


import 'models/note_app_model.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAppModelAdapter());
  await Hive.openBox("Notes");
  SharedPreferenceHelper.init();
  runApp(const AppRoot());
}
