class Etat {
  final int idEtat;
  final DateTime lastUpdate;

  const Etat({
    required this.idEtat,
    required this.lastUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEtat': idEtat,
      'lastUpdate': lastUpdate,
    };
  }

  @override
  String toString() {
    return 'Etat{idEtat: $idEtat, lastUpdate: $lastUpdate}';
  }
}
