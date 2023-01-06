// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'package:flutter_auth/models/Matricula.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Welcome/components/login_signup_btn.dart';
import '../../Welcome/components/welcome_image.dart';
import '../../Welcome/welcome_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

TextEditingController Nnegocio = TextEditingController();
TextEditingController Gironegocio = TextEditingController();
TextEditingController Telefono = TextEditingController();
var _latitude = "";
var _longitud = "";
final ImagePicker _picker = ImagePicker();
PickedFile? INE;
PickedFile? DOMI;
PickedFile? FOTO;
var matricula;
var leerMatricula;
var _openResult = 'Unknown';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);
  _SignUpFormState createState() => _SignUpFormState();
}

@override
class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    readCounter();

    //Notification();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          if (leerMatricula == null)
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              controller: Nnegocio,
              onSaved: (input) => Nnegocio.text = input!,
              decoration: const InputDecoration(
                hintText: "Nombre",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),
          //PHONE NUMBER WITH COUNTRY
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   height: 80,
          //   child: IntlPhoneField(
          //     decoration: const InputDecoration(
          //       counter: Offstage(),
          //       labelText: 'Mobile Number',
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide(),
          //       ),
          //     ),
          //     initialCountryCode: 'IN',
          //     showDropdownIcon: true,
          //     dropdownIconPosition: IconPosition.trailing,
          //     onChanged: (phone) {
          //       print(phone.completeNumber);
          //     },
          //   ),
          // ),
          if (leerMatricula == null)
            TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              controller: Telefono,
              onSaved: (input) => Nnegocio.text = input!,
              decoration: const InputDecoration(
                hintText: "Telefono",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),
          if (leerMatricula == null) INES(),
          if (leerMatricula == null)
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Tomar Foto'),
                            onTap: () {
                              UploadINEfoto();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('Galeria'),
                            onTap: () {
                              UploadINE();
                            },
                          ),
                        ],
                      );
                    });

                //UploadGallery();
              },
              decoration: InputDecoration(
                hintText: "INE",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                prefixIcon: const Icon(
                  Icons.sd_card_rounded,
                  color: Colors.black,
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),
          if (leerMatricula == null) DOMIC(),
          if (leerMatricula == null)
            TextFormField(
              readOnly: true,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Tomar Foto'),
                            onTap: () {
                              UploadDOMIfoto();
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.photo),
                            title: new Text('Galeria'),
                            onTap: () {
                              UploadDOMI();
                            },
                          ),
                        ],
                      );
                    });

                //UploadGallery();
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Comproante de Domicilio",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                prefixIcon: const Icon(
                  Icons.maps_home_work,
                  color: Colors.black,
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          if (leerMatricula == null) FOTOGRAFIA(),
          if (leerMatricula == null)
            TextFormField(
              readOnly: true,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(Icons.camera_alt),
                            title: new Text('Tomar Foto'),
                            onTap: () {
                              UploadFOTOfoto();
                              //UploadINEfoto();
                              // takePhoto(ImageSource.camera);
                              // print(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.photo),
                            title: new Text('Galeria'),
                            onTap: () {
                              UploadFOTO();
                              // UploadINE();
                              //takePhoto(ImageSource.gallery);
                              //print(ImageSource.gallery);
                            },
                          ),

                          // if (user == "Edwin Poot")
                          //   ListTile(
                          //     leading: new Icon(Icons.info),
                          //     title: new Text('Detalles'),
                          //     onTap: () {},
                          //   ),
                          // ListTile(
                          //   leading: new Icon(Icons.share),
                          //   title: new Text('Otro'),
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
                        ],
                      );
                    });

                //UploadGallery();
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Fotografia",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                prefixIcon: const Icon(
                  Icons.photo_camera_front_rounded,
                  color: Colors.black,
                ),
              ),
            ),

          const SizedBox(height: defaultPadding / 2),
          if (leerMatricula == null)
            ElevatedButton(
              onPressed: () async {
                if (Nnegocio.text.toString() == "") {
                  print("LLena todos los campos");
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text(
                      "LLena todos los campos ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (INE == null) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text(
                      "Te Falto La Fotografia del INE",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (DOMI == null) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text(
                      "Te Falto el Comporbante de Domicilio",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (FOTO == null) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text(
                      "Te Falto Una Fotografia",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.yellow,
                    content: Text(
                      "Espere un momento " + Nnegocio.text.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //ENVIAR DATOS
                  print("INE: " +
                      INE!.path.toString() +
                      "\n" +
                      "Domicilio: " +
                      DOMI!.path.toString() +
                      "\n" +
                      "Fotografia: " +
                      FOTO!.path.toString() +
                      "\n" +
                      Nnegocio.text.toString() +
                      "\n" +
                      Telefono.text.toString() +
                      "\n" +
                      _latitude.toString() +
                      "\n" +
                      _longitud.toString());

                  Sendimages(
                      INE!.path.toString(),
                      DOMI!.path.toString(),
                      FOTO!.path.toString(),
                      Nnegocio.text.toString(),
                      Telefono.text.toString(),
                      _latitude.toString(),
                      _longitud.toString());

                  // openFiles(matricula.toString());

                  // print(Nnegocio.text.toString());

                }
              },
              child: Text("Registrarse".toUpperCase()),
            ),
          const SizedBox(height: defaultPadding),

          const SizedBox(height: defaultPadding),
          if (leerMatricula != null)
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
          // TextFormField(

          //   readOnly: true,
          //   keyboardType: TextInputType.emailAddress,
          //   decoration: InputDecoration(
          //     hintText: "Tu matricula es: " + matricula.toString(),
          //     enabledBorder: UnderlineInputBorder(
          //         borderSide: BorderSide(
          //             color: Theme.of(context).accentColor.withOpacity(0.2))),
          //     focusedBorder: UnderlineInputBorder(
          //         borderSide:
          //             BorderSide(color: Theme.of(context).accentColor)),
          //     prefixIcon: const Icon(
          //       Icons.mark_chat_read,
          //       color: Colors.green,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  UploadINE() async {
    final ine = await _picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      // _imageFile = ine;
      INE = ine;
    });
  }

  UploadINEfoto() async {
    final ine = await _picker.getImage(
      source: ImageSource.camera,
    );

    setState(() {
      // _imageFile = ine;
      INE = ine;
    });
  }

  Widget INES() {
    return Center(
      child: Stack(
        children: <Widget>[
          //Image.network("https://actasalinstante.com:3030/api/user/avatar/"),
          if (INE != null)
            CircleAvatar(
              radius: 20.0,
              backgroundImage: FileImage(File(INE!.path)),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CircleAvatar(
              radius: 1.0,
              backgroundColor: Colors.white,
            ),
          ),

          Positioned(
            bottom: 19.0,
            left: 2.0,
            top: 2.0,
            width: 20,
            child: InkWell(
              onTap: () {
                // showModalBottomSheet(
                //     context: context,
                //     builder: (context) {
                //       return Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           ListTile(
                //             leading: new Icon(Icons.camera_alt),
                //             title: new Text('Tomar Foto'),
                //             onTap: () {
                //               // UploadCamera();
                //               // takePhoto(ImageSource.camera);
                //               // print(ImageSource.camera);
                //             },
                //           ),
                //           ListTile(
                //             leading: new Icon(Icons.photo),
                //             title: new Text('Galeria'),
                //             onTap: () {
                //               // UploadGallery();
                //               //takePhoto(ImageSource.gallery);
                //               //print(ImageSource.gallery);
                //             },
                //           ),

                //           // if (user == "Edwin Poot")
                //           //   ListTile(
                //           //     leading: new Icon(Icons.info),
                //           //     title: new Text('Detalles'),
                //           //     onTap: () {},
                //           //   ),
                //           // ListTile(
                //           //   leading: new Icon(Icons.share),
                //           //   title: new Text('Otro'),
                //           //   onTap: () {
                //           //     Navigator.pop(context);
                //           //   },
                //           // ),
                //         ],
                //       );
                //     });
                // showModalBottomSheet(
                //   context: context,
                //   builder: ((builder) => bottomSheet()),
                // );
              },
              // child: Icon(
              //   Icons.sd_card_rounded,
              //   color: Colors.black,
              //   size: 35.0,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  //////DOMICILIO//////////
  UploadDOMI() async {
    final domi = await _picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      // _imageFile = ine;
      DOMI = domi;
    });
  }

  UploadDOMIfoto() async {
    final domi = await _picker.getImage(
      source: ImageSource.camera,
    );

    setState(() {
      // _imageFile = ine;
      DOMI = domi;
    });
  }

  Widget DOMIC() {
    return Center(
      child: Stack(
        children: <Widget>[
          //Image.network("https://actasalinstante.com:3030/api/user/avatar/"),
          if (DOMI != null)
            CircleAvatar(
              radius: 20.0,
              backgroundImage: FileImage(File(DOMI!.path)),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CircleAvatar(
              radius: 1.0,
              backgroundColor: Colors.white,
            ),
          ),

          Positioned(
            bottom: 19.0,
            left: 2.0,
            top: 2.0,
            width: 20,
            child: InkWell(
              onTap: () {},
              // child: Icon(
              //   Icons.sd_card_rounded,
              //   color: Colors.black,
              //   size: 35.0,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  ////////////FOTOGAFRIA/////////////

  Widget FOTOGRAFIA() {
    return Center(
      child: Stack(
        children: <Widget>[
          if (FOTO != null)
            CircleAvatar(
              radius: 20.0,
              backgroundImage: FileImage(File(FOTO!.path)),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CircleAvatar(
              radius: 1.0,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  UploadFOTO() async {
    final foto = await _picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      // _imageFile = ine;
      FOTO = foto;
    });
  }

  UploadFOTOfoto() async {
    final foto = await _picker.getImage(
      source: ImageSource.camera,
    );

    setState(() {
      // _imageFile = ine;
      FOTO = foto;
    });
  }

  Sendimages(ine, domi, fot, name, telef, lati, longi) async {
    try {
      var URI_API =
          Uri.parse('http://actasalinstante.com:3031/api/users/signup/');
      var req = new http.MultipartRequest("POST", URI_API);
      req.fields['name'] = name;
      req.fields['number_phone'] = telef;
      req.fields['latitud'] = lati;
      req.fields['longitud'] = longi;

      req.files.add(await http.MultipartFile.fromPath('INE', ine.toString(),
          contentType: MediaType('image', 'jpg')));
      req.files.add(await http.MultipartFile.fromPath(
          'Domicilio', domi.toString(),
          contentType: MediaType('image', 'jpg')));
      req.files.add(await http.MultipartFile.fromPath('Foto', fot.toString(),
          contentType: MediaType('image', 'jpg')));

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      } else {
        req
            .send()
            .then((res) => {
                  res.stream.transform(utf8.decoder).listen((val) async {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      content: Text(
                        "Datos Enviados: " + val.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    );
                    matricula = val;
                    // getIt<AuthModel>().matricula = val;
                    Nnegocio.clear();
                    Telefono.clear();
                    setState(() {
                      INE = null;
                    });
                    setState(() {
                      DOMI = null;
                    });
                    setState(() {
                      FOTO = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    await Future.delayed(Duration(seconds: 5));
                    writeCounter(matricula.toString());
                    print(val);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                WelcomeScreen()));
                  })
                })
            .catchError((err) => {print(err.toString())});
      }
      print(status);
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          "Datos No Enviados: " + e.toString(),
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

//GPS
  _getCurrentLocation() async {
    Position position = await _determinePosition();

    _latitude = position.latitude.toString();
    _longitud = position.longitude.toString();
    print(_latitude.toString() + "\n" + _longitud.toString());
    readCounter();
    (context as Element).reassemble();
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
      print("No se encontro");
      return 0;
    }
  }

//Escribe el Archivo
  writeCounter(String counter) async {
    final file = await _localFile;
    print(file.toString());
    // Escribir archivo
    return file.writeAsString('$counter');
  }
}
