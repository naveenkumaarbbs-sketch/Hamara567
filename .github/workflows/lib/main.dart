import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/inactivity_watcher.dart';
import 'screens/login_screen.dart';
import 'screens/games_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/game_detail.dart';

// NOTE: This main assumes Firebase will initialize with defaults in CI.
// It's a minimal UI: Games list + Profile + Game detail.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HamaraApp());
}

class HamaraApp extends StatelessWidget {
  const HamaraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InactivityWatcher(
      timeout: const Duration(minutes: 2),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hamara567',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber,
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: '/',
        routes: {
          '/': (c) => const Root(),
          '/login': (c) => const LoginScreen(),
          '/gameDetail': (c) => const GameDetailScreen(),
          '/profile': (c) => const ProfileScreen(),
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    // We route to Games page by default (no auth check here to keep CI simple)
    return const HomeShell();
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({Key? key}) : super(key: key);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selected = 0;
  static const List<Widget> _pages = <Widget>[
    GamesScreen(),
    ProfileScreen(),
  ];

  void _onTap(int index) => setState(() => _selected = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
