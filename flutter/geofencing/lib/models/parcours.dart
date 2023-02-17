class Parcours {
  final int idParcours;
  final String titre;
  final int duree;

  const Parcours({
    required this.idParcours,
    required this.titre,
    required this.duree,
  });

  Map<String, dynamic> toMap() {
    return {
      'idParcours': idParcours,
      'titre': titre,
      'duree': duree,
    };
  }

  @override
  String toString() {
    return 'Parcours{id: $idParcours, name: $titre, age: $duree}';
  }
}
