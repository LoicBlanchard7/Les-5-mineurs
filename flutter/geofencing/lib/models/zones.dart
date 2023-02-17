class Zones {
  final int idZone;
  final String titre;
  final int idPoint;

  const Zones({
    required this.idZone,
    required this.titre,
    required this.idPoint,
  });

  Map<String, dynamic> toMap() {
    return {
      'idZone': idZone,
      'titre': titre,
      'idPoint': idPoint,
    };
  }

  @override
  String toString() {
    return 'Zones{idZone: $idZone, titre: $titre, idPoint: $idPoint}';
  }
}
