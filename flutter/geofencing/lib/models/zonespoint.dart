class ZonesPoint {
  final int idZonePoint;
  final int idZone;
  final String item;
  final String collection;

  const ZonesPoint(
      {required this.idZonePoint,
      required this.idZone,
      required this.item,
      required this.collection});

  Map<String, dynamic> toMap() {
    return {
      'idZonePoint': idZonePoint,
      'idZone': idZone,
      'item': item,
      'collection': collection,
    };
  }

  @override
  String toString() {
    return 'ZonesPoint{idZonePoint: $idZonePoint, idZone: $idZone, item: $item, collection: $collection}';
  }
}
