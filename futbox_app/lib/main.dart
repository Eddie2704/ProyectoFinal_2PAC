import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futbox_app/firebase_options.dart';
import 'package:futbox_app/src/views/calendariopage.dart';
import 'package:futbox_app/src/views/homepage.dart';
import 'package:futbox_app/src/views/loginpage.dart';
import 'package:futbox_app/src/views/reservepage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicializar datos de localización para fechas en español
  await initializeDateFormatting('es', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),

      GoRoute(
        path: '/reservepage',
        builder: (context, state) => ReservePage(nombrecancha: "Cancha 3"),
      ),
      GoRoute(
        path: '/calendariopage',
        builder: (context, state) => CalendarioPage(canchaId: "Cancha 3"),
      ),
      GoRoute(path: '/perfil/:id', builder: (context, state) => Loginpage()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'App de Reservas', routerConfig: _router);
  }
}
