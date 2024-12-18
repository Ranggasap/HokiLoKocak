import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/LoginFeature/LoginPage.dart';
import 'package:hoki_lo_kocak/MainPage.dart';
import 'package:hoki_lo_kocak/firebase_options.dart';
import 'package:hoki_lo_kocak/models/game_state.dart';
import 'package:hoki_lo_kocak/screens/dice_roll_screen.dart';
import 'package:hoki_lo_kocak/screens/BattleScreen.dart';
import 'package:hoki_lo_kocak/screens/WinScreen.dart';
import 'package:hoki_lo_kocak/screens/LoseScreen.dart';
import 'package:hoki_lo_kocak/screens/rock_paper_scissors_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hoki Lo Kocak',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/mainpage': (context) => MainPage(),
        '/battle': (context) => BattleScreen(),
        '/lose': (context) => LoseScreen(),
        '/rock-paper-scissors': (context) => RockPaperScissorsScreen(),
        '/dice-roll': (context) => DiceRollScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/win') {
          final args = settings.arguments as Map<String, dynamic>;

          // Make sure to check if the arguments exist before passing them
          return MaterialPageRoute(
            builder: (context) => WinScreen(
              email: args['email'],        // Email argument passed
              win: args['win'],            // Win argument passed
              lose: args['lose'],          // Lose argument passed
              winrate: args['winrate'],    // Win rate argument passed
              rank: args['rank'],          // Rank argument passed
            ),
          );
        }
        return null; // Handle other routes
      },
    );
  }
}
