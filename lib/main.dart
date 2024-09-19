import 'package:bcwallet/pages/home-page.dart';
import 'package:bcwallet/pages/login-part.dart';
import 'package:bcwallet/pages/register-page.dart';
import 'package:bcwallet/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bcwallet/firebase_options.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.instance.registerSingleton<FirebaseServices>(FirebaseServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BC Wallet',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: 'homepage',
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'homepage': (context) => HomePage(),
      },
    );
  }
}
