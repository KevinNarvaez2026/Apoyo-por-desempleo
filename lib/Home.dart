import 'dart:convert';
import 'dart:io';
// import 'package:app_actasalinstante/NavBar.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:app_actasalinstante/Widgets/carousel_example.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../FlatMessage/Message.dart';
// import '../RFCDescargas/services/Variables.dart';
// import '../views/controller/controller.dart';

enum ViewDialogsAction { yes, no }

class Body extends StatefulWidget {
  const Body({key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}
// Puedes pasar cualquier objeto al parámetro `arguments`. En este ejemplo, crea una
// clase que contiene ambos, un título y un mensaje personalizable.

class _BodyState extends State<Body> {
  TextEditingController ActoController = TextEditingController();
  TextEditingController curpController = TextEditingController();
  TextEditingController etadoController = TextEditingController();
  //TextEditingController prefereneController = TextEditingController();


 
  // curpValida( String curp) {

  //   var re =
  //           "/^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)/",
  //       validado = curp.match(re);

  //   if (!validado) //Coincide con el formato general?
  //     return false;

  //   //Validar que coincida el dígito verificador
  //   digitoVerificador(String curp17) {
  //     //Fuente https://consultas.curp.gob.mx/CurpSP/
  //     var diccionario = "0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ",
  //         lngSuma = 0.0,
  //         lngDigito = 0.0;
  //     for (var i = 0; i < 17; i++)
  //       lngSuma = lngSuma + diccionario.indexOf(curp17[i]) * (18 - i);
  //     lngDigito = 10 - lngSuma % 10;
  //     if (lngDigito == 10) return 0;
  //     return lngDigito;
  //   }

  //   if (validado[2] != digitoVerificador(validado[1])) return false;

  //   return true; //Validado
  // }


  String label = "Seleciona el Acto Registral";
  String curp = "Ingresa tu Curp";
  String estado = "Seleciona el Estado\n";
  var _currentSelectedValue;
  var _estadoselect;

  var _currencies = ["Nacimiento", "Defuncion", "Matrimonio", "Divorcio"];
  var estados = [
    "Aguascalientes",
    "Baja California",
    "Baja California Sur",
    "Campeche",
    "Chiapas",
    "Chihuahua",
    "Coahuila",
    "Colima",
    "Distrito Federal",
    "Durango",
    "Guanajuato",
    "Guerrero",
    "Hidalgo",
    "Jalisco",
    "Estado de México",
    "Michoacán",
    "Morelos",
    "Nayarit",
    "Nuevo León",
    "Oaxaca",
    "Puebla",
    "Querétaro",
    "Quintana Roo",
    "San Luis Potosí",
    "Sinaloa",
    "Sonora",
    "Tabasco",
    "Tamaulipas",
    "Tlaxcala",
    "Veracruz",
    "Yucatán",
    "Zacatecas",
  ];
  @override
  Widget build(BuildContext context) {
    var crupestado;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Actas Al Instante ',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Actas",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Solicitar acta",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                        
                            // TextFormField(

                            //   controller: ActoController,

                            //   pohjhjhhdecoration: InputDecoration(hintText: 'Acto registral'.toUpperCase() ),
                            // ),
                            SizedBox(
                              //Use of SizedBox
                              height: 5,
                            ),

                            TextFormField(
                              controller: curpController,
                              validator: (input) =>
                                  input == '' ? "Ingresa un usuario" : null,
                              decoration: InputDecoration(
                                  label: Text(curp.toString()),
                                  hintText: 'curp'.toUpperCase()),
                              maxLength: 18,
                              onSaved: onChangeCurp(
                                  curpController.text.toString().toUpperCase()),

                              //  obscureText: true,
                            ),
                            // ),
                            SizedBox(
                              //Use of SizedBox
                              height: 10,
                            ),

                            // FormField<String>(
                            //   builder: (FormFieldState<String> state) {
                            //     return InputDecorator(
                            //       decoration: InputDecoration(
                            //           label: Text(
                            //               estado.toString() + entidad.toString()),
                            //           errorStyle: TextStyle(
                            //               color: Colors.redAccent, fontSize: 16.0),
                            //           hintText: 'Please select expense',
                            //           border: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(5.0))),
                            //       isEmpty: _estadoselect == '',
                            //       child: DropdownButtonHideUnderline(
                            //         child: DropdownButton<String>(
                            //           value: _estadoselect,
                            //           isDense: true,
                            //           onChanged: (String newValue) {
                            //             setState(() {
                            //               entidad = newValue;
                            //               state.didChange(newValue);
                            //             });
                            //           },
                            //           items: estados.map((String value) {
                            //             return DropdownMenuItem<String>(
                            //               value: value,
                            //               child: Text(value),
                            //             );
                            //           }).toList(),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            // T
                            if (entidad.toString() != "Entidad de registro")
                              TextFormField(
                                controller: etadoController,
                                decoration: InputDecoration(
                                    hintText: '' + entidad.toString(),
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.green,
                                    filled: true, // dont forget this line
                                    hintStyle: TextStyle(color: Colors.white)),
                                readOnly: true,

                                // obscureText: true,
                              ),
                            if (entidad.toString() == "Entidad de registro")
                              TextFormField(
                                controller: etadoController,
                                decoration: InputDecoration(
                                    hintText: '' + entidad.toString(),
                                    contentPadding: const EdgeInsets.all(20),
                                    fillColor: Colors.red,
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.white)),

                                readOnly: true,

                                // obscureText: true,
                              ),

                            // inputFile(label: "Correo"),
                            // inputFile(label: "Contraseña", obscureText: true)
                          ],
                        ),
                      ),
                      if (entidad.toString() == "Entidad de registro")
                        new Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(82),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 21, vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                  onPressed: null,
                                  onLongPress: null,
                                  child: Text("LLena Los Campos"),
                                  textColor: Colors.white,
                                ),
                                Icon(
                                  Icons.close,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (entidad.toString() != "Entidad de registro")
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Container(
                            padding: EdgeInsets.only(top: 1, left: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                )),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                             
                              },
                              color: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Enviar",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Container(
                      //   padding: EdgeInsets.only(top: 100),
                      //   height: 200,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage("assets/background.png"),
                      //         fit: BoxFit.fitHeight),
                      //   ),
                      // )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  int entidadValue = 0;
  var entidad;
  late String bdEstado;

  var nose;
  onChangeCurp(String curp) {
    if (curp.length == 18) {
      curpController.text = curp;

      var res = curp[11] + curp[12];
      //  print(res.toString().toUpperCase());
      //  print(entidad);
      switch (res.toString().toUpperCase()) {
        case 'AS':
          {
            entidadValue = 1;
            entidad = 'AGUASCALIENTES';
            bdEstado = 'n0';
            nose = "1";
            break;
          }
        case 'BC':
          {
            entidadValue = 2;
            entidad = 'BAJA CALIFORNIA';
            bdEstado = 'n1';
            nose = "2";
            break;
          }
        case 'BS':
          {
            entidadValue = 3;
            entidad = 'BAJA CALIFORNIA SUR';
            bdEstado = 'n2';
            nose = "3";
            break;
          }
        case 'CC':
          {
            entidadValue = 4;
            entidad = 'CAMPECHE';
            bdEstado = 'n3';
            nose = "4";

            break;
          }
        case "CS":
          {
            entidadValue = 7;
            entidad = 'CHIAPAS';
            bdEstado = 'n4';
            nose = "5";
            // print(entidadValue);
            break;
          }
        case 'CH':
          {
            entidadValue = 8;
            entidad = 'CHIHUAHUA';
            bdEstado = 'n5';
            nose = "6";
            break;
          }
        case 'DF':
          {
            entidadValue = 9;
            entidad = 'DISTRITO FEDERAL';
            bdEstado = 'n6';
            nose = "7";
            break;
          }
        case 'CL':
          {
            entidadValue = 5;
            entidad = 'COAHUILA DE ZARAGOZA';
            bdEstado = 'n7';
            nose = "8";
            break;
          }
        case 'CM':
          {
            entidadValue = 6;
            entidad = 'COLIMA';
            bdEstado = 'n8';
            nose = "9";
            break;
          }
        case 'DG':
          {
            entidadValue = 10;
            entidad = 'DURANGO';
            bdEstado = 'n9';
            nose = "10";
            break;
          }
        case 'GT':
          {
            entidadValue = 11;
            entidad = 'GUANAJUATO';
            bdEstado = 'n10';
            nose = "11";
            break;
          }
        case 'GR':
          {
            entidadValue = 12;
            entidad = 'GUERRERO';
            bdEstado = 'n11';
            nose = "12";
            break;
          }
        case 'HG':
          {
            entidadValue = 13;
            entidad = 'HIDALGO';
            bdEstado = 'n12';
            nose = "13";
            break;
          }
        case 'JC':
          {
            entidadValue = 14;
            entidad = 'JALISCO';
            bdEstado = 'n13';
            nose = "14";
            break;
          }
        case 'MC':
          {
            entidadValue = 15;
            entidad = 'MEXICO';
            bdEstado = 'n14';
            nose = "15";
            break;
          }
        case 'MN':
          {
            entidadValue = 16;
            entidad = 'MICHOACAN';
            bdEstado = 'n15';
            nose = "16";
            break;
          }
        case 'MS':
          {
            entidadValue = 17;
            entidad = 'MORELOS';
            bdEstado = 'n16';
            nose = "17";
            break;
          }
        case 'NT':
          {
            entidadValue = 18;
            entidad = 'NAYARIT';
            bdEstado = 'n17';
            nose = "18";
            break;
          }
        case 'NL':
          {
            entidadValue = 19;
            entidad = 'NUEVO LEON';
            bdEstado = 'n18';
            nose = "19";
            break;
          }
        case 'OC':
          {
            entidadValue = 20;
            entidad = 'OAXACA';
            bdEstado = 'n19';
            nose = "20";
            break;
          }
        case 'PL':
          {
            entidadValue = 21;
            entidad = 'PUEBLA';
            bdEstado = 'n20';
            nose = "21";
            break;
          }
        case 'QT':
          {
            entidadValue = 22;
            entidad = 'QUERETARO';
            bdEstado = 'n21';
            nose = "22";
            break;
          }
        case 'QR':
          {
            entidadValue = 23;
            entidad = 'QUINTANA ROO';
            bdEstado = 'n22';
            nose = "23";
            break;
          }
        case 'SP':
          {
            entidadValue = 24;
            entidad = 'SAN LUIS POTOSI';
            bdEstado = 'n23';
            nose = "24";
            break;
          }
        case 'SL':
          {
            entidadValue = 25;
            entidad = 'SINALOA';
            bdEstado = 'n24';
            nose = "25";
            break;
          }
        case 'SR':
          {
            entidadValue = 26;
            entidad = 'SONORA';
            bdEstado = 'n25';
            nose = "26";
            break;
          }
        case 'TC':
          {
            entidadValue = 27;
            entidad = 'TABASCO';
            bdEstado = 'n26';
            nose = "27";
            break;
          }

        case 'TS':
          {
            entidadValue = 28;
            entidad = 'Entidad no disponible';
            bdEstado = 'n27';
            nose = "28";
            break;
          }
        case 'TL':
          {
            entidadValue = 29;
            entidad = 'TLAXCALA';
            bdEstado = 'n28';
            nose = "29";
            break;
          }
        case 'VZ':
          {
            entidadValue = 30;
            entidad = 'VERACRUZ';
            bdEstado = 'n29';
            nose = "30";
            break;
          }
        case 'YN':
          {
            entidadValue = 31;
            entidad = 'YUCATAN';
            bdEstado = 'n30';
            nose = "31";
            break;
          }
        case 'ZS':
          {
            entidadValue = 32;
            entidad = 'ZACATECAS';
            bdEstado = 'n31';
            nose = "32";
            break;
          }
        default:
          {
            entidadValue = 39;
            entidad = 'NACIDO EN EL EXTRANJERO';
            bdEstado = 'n32';
            nose = "33";
            break;
          }
      }
    } else {
      entidad = 'Entidad de registro';
    }
  }
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
