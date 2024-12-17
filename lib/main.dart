import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/LoginFeature/LoginPage.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:
          '/login', // Tetapkan rute awal ke rock_paper_scissors_screen
      routes: {
        '/login': (context) => LoginPage(),
        '/battle': (context) => BattleScreen(),
        '/win': (context) => WinScreen(),
        '/lose': (context) => LoseScreen(),
        '/rock_paper_scissors': (context) => RockPaperScissorsScreen(),
        '/dice-roll': (context) => DiceRollScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'test:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
