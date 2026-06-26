class Tontine {
  final String id;
  final String nom;
  final String description;
  final double montantCotisation;
  final int frequenceJours;
  final DateTime dateDebut;
  final String createurId;
  final bool estActive;

  Tontine({
    required this.id,
    required this.nom,
    required this.description,
    required this.montantCotisation,
    required this.frequenceJours,
    required this.dateDebut,
    required this.createurId,
    this.estActive = true,
  });

  factory Tontine.fromJson(Map<String, dynamic> json) {
    return Tontine(
      id: json['id'],
      nom: json['nom'],
      description: json['description'] ?? '',
      montantCotisation: (json['montant_cotisation'] as num).toDouble(),
      frequenceJours: json['frequence_jours'] ?? 30,
      dateDebut: DateTime.parse(json['date_debut']),
      createurId: json['createur_id'],
      estActive: json['est_active'] ?? true,
    );
  }
}