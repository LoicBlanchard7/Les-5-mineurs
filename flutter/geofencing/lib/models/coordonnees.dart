class Coordonnees {
  final int idCoo;
  final int idZone;
  final double posX;
  final double posY;

  const Coordonnees({
    required this.idCoo,
    required this.idZone,
    required this.posX,
    required this.posY,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCoo': idCoo,
      'idZone': idZone,
      'posX': posX,
      'posY': posY,
    };
  }

  @override
  String toString() {
    return 'Coordonnees{idCoo: $idCoo, idZone: $idZone, posX: $posX, posY: $posY}';
  }
}
