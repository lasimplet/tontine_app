import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/tontine.dart';
import '../widgets/stat_card.dart';
import 'create_tontine_screen.dart';

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
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tableau de Bord')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadTontines,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Vue d\'ensemble', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.7,
                children: [
                  StatCard(title: "Tontines", value: _tontines.length.toString(), emoji: "🏛️"),
                  const StatCard(title: "Membres", value: "18", emoji: "👥"),
                  const StatCard(title: "Épargne", value: "1.8M", emoji: "💰"),
                  const StatCard(title: "Progression", value: "92%", emoji: "📈", color: Colors.green),
                ],
              ),

              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mes Tontines', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('Voir tout')),
                ],
              ),

              _tontines.isEmpty
                  ? const Center(child: Text('Aucune tontine. Créez-en une !'))
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _tontines.length,
                itemBuilder: (context, index) {
                  final t = _tontines[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFFD4A017),
                        child: Icon(Icons.account_balance_wallet, color: Colors.white, size: 28),
                      ),
                      title: Text(t.nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text(t.description, maxLines: 2),
                      trailing: Text('${t.montantCotisation} FCFA',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                    ),
                  );
                },
              ),
            ],
          ),
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