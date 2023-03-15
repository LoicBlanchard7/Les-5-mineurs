import 'package:flutter/material.dart';
import 'package:geofencing/database/geofencingBDD.dart';
import 'package:geofencing/global.dart';
import 'pages/accueil.dart';

void main() {
  geofencingBDD.launchdatabase();

  Global.changePointToZonePoint();

  runApp(const MaterialApp(
      home: AccueilPage(), debugShowCheckedModeBanner: false));
}
