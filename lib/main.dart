import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wxkbzomgukgsngvsxmfu.supabase.co',
    anonKey: 'sb_publishable_nvhkYfAOYn9TPkHiho2_ww_HpkdWJVx', // ← Change si tu as copié la nouvelle
  );

  runApp(const TontineApp());
}

final supabase = Supabase.instance.client;

class TontineApp extends StatelessWidget {
  const TontineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tontine App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}