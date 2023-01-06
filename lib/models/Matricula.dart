import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AuthModel {
  

  String matricula ;

   
   AuthModel({required this.matricula});
   
}

Future<void> setup() async {
  
  getIt.registerSingleton<AuthModel>(AuthModel(matricula: ""));
 // print(getIt);
}