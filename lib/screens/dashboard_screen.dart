import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/tontine.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    }
  }

  Future<void> _logout() async {
    await _service.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord - Tontine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mes Tontines', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: _tontines.isEmpty
                  ? const Center(child: Text('Aucune tontine trouvée.\nAppuyez sur + pour créer', textAlign: TextAlign.center))
                  : ListView.builder(
                itemCount: _tontines.length,
                itemBuilder: (context, index) {
                  final tontine = _tontines[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet, size: 40, color: Colors.deepPurple),
                      title: Text(tontine.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(tontine.description),
                      trailing: Text('${tontine.montantCotisation} FCFA', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Création de tontine (à faire avec Ursula)'))),
        child: const Icon(Icons.add),
      ),
    );
  }
}