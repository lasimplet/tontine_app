class Membre {
  final String id;
  final String nom;
  final String prenom;
  final String telephone;
  final String? email;
  final DateTime? dateInscription;
  final String? photoUrl;

  Membre({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    this.email,
    this.dateInscription,
    this.photoUrl,
  });

  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      telephone: json['telephone'] ?? '',
      email: json['email'],
      dateInscription: json['date_inscription'] != null
          ? DateTime.parse(json['date_inscription']) : null,
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'photo_url': photoUrl,
    };
  }
}