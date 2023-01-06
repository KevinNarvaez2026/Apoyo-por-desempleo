import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/ProgressHUD.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_filex/open_filex.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/login_signup_btn.dart';
import 'components/welcome_image.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

var _latitude = "";
var _longitud = "";
bool isApiCallProcess = false;

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    readCounter();
    _getCurrentLocation();

    setState(() {
      isApiCallProcess = true;
    });
    //Notification();
  }

  Permisos() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {}
    print(status);
  }

  //GPS
  _getCurrentLocation() async {
    Position position = await _determinePosition();
    Permisos();
    _latitude = position.latitude.toString();
    _longitud = position.longitude.toString();
    print(_latitude.toString() + "\n" + _longitud.toString());
    readCounter();
    (context as Element).reassemble();
    setState(() {
      isApiCallProcess = false;
    });
    // Navigator.pop(context);
    //Put_GPS(_latitude, _longitud);
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
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

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: iui(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      key: Key(isApiCallProcess.toString()),
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }

  Widget iui(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: WelcomeImage(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 450,
                        child: LoginAndSignupBtn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: const MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
