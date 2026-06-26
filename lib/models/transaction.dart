class Transaction {
  final String id;
  final String tontineId;
  final String membreId;
  final double montant;
  final DateTime dateTransaction;
  final String type; // 'cotisation', 'retrait', 'penalite'

  Transaction({
    required this.id,
    required this.tontineId,
    required this.membreId,
    required this.montant,
    required this.dateTransaction,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      tontineId: json['tontine_id'],
      membreId: json['membre_id'],
      montant: (json['montant'] as num).toDouble(),
      dateTransaction: DateTime.parse(json['date_transaction']),
      type: json['type'],
    );
  }
}