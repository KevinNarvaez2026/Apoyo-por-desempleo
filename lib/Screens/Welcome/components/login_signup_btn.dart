import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatefulWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);
  _LoginAndSignupBtnState createState() => _LoginAndSignupBtnState();
}

var leerMatricula;
var _openResult = 'Unknown';

@override
class _LoginAndSignupBtnState extends State<LoginAndSignupBtn> {
  @override
  void initState() {
    super.initState();

    setState(() {
      readCounter();
      pressReload();
    });

    //openFiles(leerMatricula.toString());
    //Notification();
  }

  pressReload() {
    (context as Element).reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (leerMatricula != null)
          // Hero(
          //   tag: "login_btn",
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).pushAndRemoveUntil(
          //           MaterialPageRoute(builder: (context) => SignUpScreen()),
          //           (Route<dynamic> route) => false);
          //     },
          //     style:
          //         ElevatedButton.styleFrom(primary: Colors.black, elevation: 0),
          //     child: Text(
          //       "Ver Matricula".toUpperCase(),
          //     ),
          //   ),
          // ),
          TextFormField(
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                decorationColor: Colors.amber),
            decoration: InputDecoration(
                hintText: 'Tu Matricula es: ' + leerMatricula.toString(),
                contentPadding: const EdgeInsets.all(10),
                fillColor: Colors.green,
                filled: true, // dont forget this line
                hintStyle: TextStyle(color: Colors.white)),
            readOnly: true,

            // obscureText: true,
          ),
        const SizedBox(height: 16),
        if (leerMatricula == null)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                  (Route<dynamic> route) => false);
            },
            style:
                ElevatedButton.styleFrom(primary: Colors.black, elevation: 0),
            child: Text(
              "Registrarse".toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Future<void> openFiles(String filename) async {
    final filePath = '/storage/emulated/0/Download/Matricula.txt';
    final result = await OpenFilex.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
      print(_openResult);
    });
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
}
