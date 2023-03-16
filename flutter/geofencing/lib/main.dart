import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geofencing/database/geofencingBDD.dart';
import 'package:geofencing/global.dart';
import 'pages/accueil.dart';

void main() {
  geofencingBDD.launchdatabase();

  Global.changePointToZonePoint();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MaterialApp(
      home: AccueilPage(), debugShowCheckedModeBanner: false));
}
