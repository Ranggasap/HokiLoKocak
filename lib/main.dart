import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/LoginFeature/LoginPage.dart';
import 'package:hoki_lo_kocak/MainPage.dart';
import 'package:hoki_lo_kocak/firebase_options.dart';
import 'package:hoki_lo_kocak/screens/dice_roll_screen.dart';
import 'package:hoki_lo_kocak/screens/rock_paper_scissors_screen.dart';
import 'screens/BattleScreen.dart';
import 'screens/WinScreen.dart';
import 'screens/LoseScreen.dart'; // Tambahkan import untuk layar menang dan kalah

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/battle': (context) => BattleScreen(),
        '/main': (context) => MainPage(),
        '/win': (context) => WinScreen(),
        '/lose': (context) => LoseScreen(),
        '/rock-paper-scissors': (context) => RockPaperScissorsScreen(),
        '/dice-roll': (context) => DiceRollScreen(),
      },
    );
  }
}
