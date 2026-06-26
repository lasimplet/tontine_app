import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tontine_app/screens/register_screen.dart';

import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/tontines_screen.dart';
import 'screens/membres_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wxkbzomgukgsngvsxmfu.supabase.co',
    anonKey: 'sb_publishable_nvhkYfAOYn9TPkHiho2_ww_HpkdWJVx',
  );

  runApp(const TontineApp());
}

final supabase = Supabase.instance.client;

class TontineApp extends StatelessWidget {
  const TontineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tontine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B4513),
          secondary: const Color(0xFFD4A017),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F5F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5C4033),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        // Correction ici : CardThemeData
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD4A017),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/tontines': (context) => const TontinesScreen(),
        '/membres': (context) => const MembresScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}