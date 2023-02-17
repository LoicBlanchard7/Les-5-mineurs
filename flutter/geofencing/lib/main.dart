import 'package:flutter/material.dart';
import 'package:geofencing/database/database.dart';
import 'package:geofencing/global.dart';
import 'pages/accueil.dart';

void main() {
  Database;

  Global.changePointToZonePoint();

  runApp(const MaterialApp(
    home: AccueilPage(),
  ));
}
