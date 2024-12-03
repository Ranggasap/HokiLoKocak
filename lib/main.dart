import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/LoginFeature/LoginPage.dart';
import 'package:hoki_lo_kocak/MainPage.dart';
import 'package:hoki_lo_kocak/firebase_options.dart';
import 'package:hoki_lo_kocak/state_util.dart';
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
      initialRoute: '/battle', // Tetapkan rute awal ke BattleScreen
      routes: {
        '/battle': (context) => BattleScreen(),
        '/win': (context) => WinScreen(),  // Tambahkan rute untuk layar menang
        '/lose': (context) => LoseScreen(), // Tambahkan rute untuk layar kalah
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
              'Wahhh ketauan lu nico:',
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
