class Zone {
  int id;
  String titre;
  String type;
  List<List<double>> coordinates;
  List<String> pointAssocie;
  List<double> coordinate;
  double radius;
  Zone(this.id, this.titre, this.type,
      [this.coordinates = const [[]],
      this.pointAssocie = const [],
      this.coordinate = const [],
      this.radius = 0]);
}
