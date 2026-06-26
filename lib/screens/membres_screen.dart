import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/membre.dart';

class MembresScreen extends StatefulWidget {
  const MembresScreen({super.key});

  @override
  State<MembresScreen> createState() => _MembresScreenState();
}

class _MembresScreenState extends State<MembresScreen> {
  final SupabaseService _service = SupabaseService();
  List<Membre> _membres = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMembres();
  }

  Future<void> _loadMembres() async {
    try {
      final membres = await _service.getMembres();
      if (mounted) {
        setState(() {
          _membres = membres;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Membres')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _membres.length,
        itemBuilder: (context, index) {
          final membre = _membres[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFD4A017),
                child: Text(
                  "${membre.prenom.isNotEmpty ? membre.prenom[0] : ''}${membre.nom.isNotEmpty ? membre.nom[0] : ''}"
                      .toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text('${membre.prenom} ${membre.nom}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(membre.telephone),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ajout de membre bientôt disponible')),
          );
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}