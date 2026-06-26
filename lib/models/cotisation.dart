class Cotisation {
  final String id;
  final String tontineId;
  final String membreId;
  final double montant;
  final DateTime dateCotisation;
  final String statut;

  Cotisation({
    required this.id,
    required this.tontineId,
    required this.membreId,
    required this.montant,
    required this.dateCotisation,
    required this.statut,
  });

  factory Cotisation.fromJson(Map<String, dynamic> json) {
    return Cotisation(
      id: json['id'],
      tontineId: json['tontine_id'],
      membreId: json['membre_id'],
      montant: (json['montant'] as num).toDouble(),
      dateCotisation: DateTime.parse(json['date_cotisation']),
      statut: json['statut'] ?? 'payee',
    );
  }
}