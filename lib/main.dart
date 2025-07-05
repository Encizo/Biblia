import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';
import 'pages/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bíblia com Estudo IA',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthService().currentUser() == null ? LoginPage() : HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}