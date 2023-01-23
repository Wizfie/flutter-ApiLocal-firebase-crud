import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/firebase_options.dart';
import 'package:flutter_crud/main_firebase.dart';
import 'package:flutter_crud/main_mysql_crud.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(const HttpRequest());
  runApp(const MainApp());
}
