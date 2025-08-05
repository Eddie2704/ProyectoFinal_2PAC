import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futbox_app/firebase_options.dart';


void main() async {
//Inicializar firebase  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    );
  }
}