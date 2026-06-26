import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/membre.dart';
import '../models/tontine.dart';
import '../models/cotisation.dart';
import '../models/transaction.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ====================== AUTH ======================
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? nom,
    String? prenom,
  }) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'nom': nom, 'prenom': prenom},
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;

  // ====================== MEMBRES ======================
  Future<List<Membre>> getMembres() async {
    final response = await supabase.from('membres').select();
    return (response as List).map((json) => Membre.fromJson(json)).toList();
  }

  Future<void> addMembre(Membre membre) async {
    await supabase.from('membres').insert(membre.toJson());
  }

  // ====================== TONTINES ======================
  Future<List<Tontine>> getTontines() async {
    final response = await supabase
        .from('tontines')
        .select()
        .eq('est_active', true)
        .order('date_debut', ascending: false);
    return (response as List).map((json) => Tontine.fromJson(json)).toList();
  }

  Future<void> createTontine(Tontine tontine) async {
    await supabase.from('tontines').insert({
      'nom': tontine.nom,
      'description': tontine.description,
      'montant_cotisation': tontine.montantCotisation,
      'frequence_jours': tontine.frequenceJours,
      'date_debut': tontine.dateDebut.toIso8601String(),
      'createur_id': supabase.auth.currentUser?.id,
    });
  }

  // ====================== COTISATIONS ======================
  Future<List<Cotisation>> getCotisations(String tontineId) async {
    final response = await supabase
        .from('cotisations')
        .select()
        .eq('tontine_id', tontineId);
    return (response as List).map((json) => Cotisation.fromJson(json)).toList();
  }

  // ====================== TRANSACTIONS ======================
  Future<List<Transaction>> getTransactions(String tontineId) async {
    final response = await supabase
        .from('transactions')
        .select()
        .eq('tontine_id', tontineId);
    return (response as List).map((json) => Transaction.fromJson(json)).toList();
  }
}