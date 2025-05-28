import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_library/screens/Home_screen.dart';
import 'package:provider/provider.dart';

import 'package:my_library/screens/Authentification.dart';
import 'package:my_library/screens/Inscription.dart';
import 'package:my_library/screens/Welcome.dart';
import 'package:my_library/screens/quiz_cong.dart';
import 'package:my_library/controller/QuizController.dart';
import 'firebase_options.dart'; // Assure-toi que ce fichier est bien configuré

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuizController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome',
      routes: {

        '/login': (context) => const Authentification(),
        '/register': (context) => const Inscription(),
        '/welcome': (context) => const Welcome(),
        '/Home': (context) =>  Home(),


      },
    );
  }
}
