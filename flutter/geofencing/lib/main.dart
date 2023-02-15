import 'package:flutter/material.dart';
import 'package:geofencing/global.dart';
import 'pages/accueil.dart';

void main() {
  Global.changePointToZonePoint();

  runApp(const MaterialApp(
    home: AccueilPage(),
  ));
}
