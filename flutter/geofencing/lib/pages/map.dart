// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/pages/ChoixParcours.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:geofencing/pages/scanQrCode.dart';
import 'package:geofencing/pages/reglages.dart';
import 'package:latlong2/latlong.dart';

import '../global.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    List<Marker> setMarkerList() {
      List<Marker> liste = [];
      for (var marker in Global.markerList) {
        if (marker.actualGoal) {
          liste.add(Marker(
            point: marker.localisation,
            builder: (context) => IconButton(
              icon: Icon(
                Icons.push_pin,
                color: Colors.red,
                shadows: const [Shadow(blurRadius: 2, color: Colors.blue)],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => detailPointDInteret(marker.id)));
              },
            ),
          ));
        } else {
          if (marker.id == null) {
            liste.add(Marker(
              point: marker.localisation,
              builder: (context) => Icon(Icons.my_location),
            ));
          } else {
            liste.add(Marker(
              point: marker.localisation,
              builder: (context) => IconButton(
                icon: marker.type,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => detailPointDInteret(marker.id)),
                  );
                },
              ),
            ));
          }
        }
      }

      return liste;
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(48.6295563, 6.107150),
                  zoom: 17,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  CircleLayer(
                    circles: Global.circles,
                  ),
                  PolygonLayer(
                    polygons: Global.polygones,
                  ),
                  MarkerLayer(
                    markers: setMarkerList(),
                  ),
                ],
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(15.0),
              padding:
                  EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 5.0,
                ),
                color: Color.fromARGB(255, 128, 183, 227),
              ),
              child: Stack(
                children: [
                  // fond circulaire bouton camera
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.circle,
                      size: 70,
                      color: Colors.black,
                    ),
                  ),
                  // BOUTON CAMERA
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const qrCodeScanner(title: 'Scan QR Code.')),
                        );
                      },
                      child: Icon(
                        Icons.cameraswitch_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // BOUTON CHOIX PARCOURS
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChoixParcours()),
                        );
                      },
                      child: Icon(
                        Icons.route_outlined,
                        size: 70,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // BOUTON REGLAGE
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReglagePage()),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        size: 70,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
