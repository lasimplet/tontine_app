import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/tontine.dart';
import 'create_tontine_screen.dart';

class TontinesScreen extends StatefulWidget {
  const TontinesScreen({super.key});

  @override
  State<TontinesScreen> createState() => _TontinesScreenState();
}

class _TontinesScreenState extends State<TontinesScreen> {
  final SupabaseService _service = SupabaseService();
  List<Tontine> _tontines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTontines();
  }

  Future<void> _loadTontines() async {
    try {
      final tontines = await _service.getTontines();
      if (mounted) {
        setState(() {
          _tontines = tontines;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Tontines')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadTontines,
        child: _tontines.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text('Aucune tontine pour le moment', style: TextStyle(fontSize: 18)),
              Text('Appuyez sur + pour en créer une'),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _tontines.length,
          itemBuilder: (context, index) {
            final t = _tontines[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFD4A017),
                  child: Icon(Icons.groups, color: Colors.white, size: 32),
                ),
                title: Text(t.nom, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('${t.description}\n${t.frequenceJours} jours'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${t.montantCotisation} FCFA', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    Text('Active', style: TextStyle(color: Colors.green[700], fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTontineScreen()),
          );
          if (result == true) _loadTontines();
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle Tontine'),
      ),
    );
  }
}