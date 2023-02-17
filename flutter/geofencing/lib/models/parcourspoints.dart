class ParcoursPoints {
  final int idParcoursPoints;
  final int idPoint;
  final int idParcour;

  const ParcoursPoints({
    required this.idParcoursPoints,
    required this.idPoint,
    required this.idParcour,
  });

  Map<String, dynamic> toMap() {
    return {
      'idParcoursPoints': idParcoursPoints,
      'idPoint': idPoint,
      'idParcour': idParcour,
    };
  }

  @override
  String toString() {
    return 'ParcoursPoints{idParcoursPoints: $idParcoursPoints, idPoint: $idPoint, idParcour: $idParcour}';
  }
}
