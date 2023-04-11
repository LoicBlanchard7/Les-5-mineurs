// ignore_for_file: non_constant_identifier_names, file_names

class Zone {
  int id;
  String Titre;
  String type;
  List<List<double>> coordinates;
  List<String> Point_associe;
  List<double> coordinate;
  double radius;
  Zone(this.id, this.Titre, this.type,
      [this.coordinates = const [[]],
      this.Point_associe = const [],
      this.coordinate = const [],
      this.radius = 0]);
}
