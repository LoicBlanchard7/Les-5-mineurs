class Zone {
  int id;
  String titre;
  String type;
  List<List<double>> coordinates;
  List<String> point_associe;
  List<double> coordinate;
  double radius;
  Zone(this.id, this.titre, this.type,
      [this.coordinates = const [[]],
      this.point_associe = const [],
      this.coordinate = const [],
      this.radius = 0]);
}
