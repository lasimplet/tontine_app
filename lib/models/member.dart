/// Modèle représentant un membre de la tontine
class Member {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime joinDate;
  final String status; // 'actif', 'inactif', 'suspendu'
  final double contribution;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    this.status = 'actif',
    this.contribution = 0.0,
  });

  /// Convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'joinDate': joinDate.toIso8601String(),
      'status': status,
      'contribution': contribution,
    };
  }

  /// Créer depuis JSON
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      joinDate: DateTime.parse(json['joinDate'] as String),
      status: json['status'] as String? ?? 'actif',
      contribution: (json['contribution'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Copier avec modifications
  Member copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    DateTime? joinDate,
    String? status,
    double? contribution,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      joinDate: joinDate ?? this.joinDate,
      status: status ?? this.status,
      contribution: contribution ?? this.contribution,
    );
  }

  @override
  String toString() => 'Member(id: $id, name: $name, email: $email)';
}
