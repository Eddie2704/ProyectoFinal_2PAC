import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futbox_app/firebase_options.dart';
import 'package:futbox_app/src/views/calendariopage.dart';
import 'package:futbox_app/src/views/homepage.dart';
import 'package:futbox_app/src/views/loginpage.dart';
//import 'package:futbox_app/src/views/loginpage.dart';
import 'package:futbox_app/src/views/reservepage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicializar datos de localización para fechas en español
  await initializeDateFormatting('es', null);

  // Inicializa el almacenamiento
  await GetStorage.init(); 
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'App de Reservas', routerConfig: GoRouter(
      redirect: (BuildContext context, GoRouterState state) {
          final isLoggedIn = GetStorage().read('isLoggedIn') ?? false;

          if (!isLoggedIn) {
            GetStorage().erase(); // borra todos los datos del alamcenamiento
            GetStorage().remove(
              'user',
            ); 
            // Si no está logueado, redirigir a la página de login
            return '/loginpage';
          }
          return null;
        },
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),

      GoRoute(
        path: '/reservepage/:index',
        builder: (context, state) {
          final indexStr = state.pathParameters['index'];
          final visualIndex = int.tryParse(indexStr ?? '');
          final realIndex = visualIndex!;
          return ReservePage(index: realIndex.toString());
        },
      ),
      
      GoRoute(
        path: '/calendariopage/:index',
        builder: (context, state) {
          final indexStr = state.pathParameters['index'];
          final visualIndex = int.tryParse(indexStr ?? '');
          final realIndex = visualIndex!;
          return CalendarioPage(index: realIndex.toString());
        },
      ),
      GoRoute(path: '/loginpage', builder: (context, state) => LoginPage()),
      
    ],
    )
    );
  }
}