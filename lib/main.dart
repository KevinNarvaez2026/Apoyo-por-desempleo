import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  _MyAppState createState() => _MyAppState();
}

var leerMatricula;

@override
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    readCounter();
    //Notification();
  }

  Future<String> get _localPath async {
    final directory = "/storage/emulated/0/Download";

    return directory;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/Matricula.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Leer archivo
      String contents = await file.readAsString();
      leerMatricula = contents;
      print("Leer " + contents);
      return int.parse(contents);
    } catch (e) {
      // Si encuentras un error, regresamos 0
      return 0;
    }
  }

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App_Register',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}
