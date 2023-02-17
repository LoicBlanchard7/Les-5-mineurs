class PointsFiles {
  final int idPointsFiles;
  final int idPoint;
  final String idDirectus;

  const PointsFiles({
    required this.idPointsFiles,
    required this.idPoint,
    required this.idDirectus,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPointsFiles': idPointsFiles,
      'idPoint': idPoint,
      'idDirectus': idDirectus,
    };
  }

  @override
  String toString() {
    return 'PointsFiles{idParcoursPoints: $idPointsFiles, idPoint: $idPoint, idDirectus: $idDirectus}';
  }
}
