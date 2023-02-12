// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import '../global.dart';
import 'package:geofencing/pages/ChoixParcours.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:geofencing/pages/scanQrCode.dart';
import 'package:geofencing/pages/reglages.dart';

Future<LocationData?> _currentLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  Location location = Location();

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  return await location.getLocation();
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    List<Marker> setMarkerList(currentLocation) {
      List<Marker> liste = [
        Marker(
          point: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          builder: (context) => Icon(Icons.location_history),
        )
      ];
      for (var marker in Global.markerList) {
        if (marker.actualGoal) {
          liste.add(Marker(
            point: marker.localisation,
            builder: (context) => IconButton(
              icon: Icon(
                Icons.my_location,
                color: Colors.red,
                size: 30,
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
                builder: (context) => GestureDetector(
                      child: marker.type,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  detailPointDInteret(marker.id)),
                        );
                      },
                    )));
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
              child: FutureBuilder<LocationData?>(
                future: _currentLocation(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
                  if (snapchat.hasData) {
                    final LocationData currentLocation = snapchat.data;
                    return FlutterMap(
                      options: MapOptions(
                        // center: LatLng(currentLocation.latitude!,
                        // currentLocation.longitude!),
                        center: LatLng(48.6295563, 6.107150),
                        zoom: 17,
                        maxZoom: 18,
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
                          markers: setMarkerList(currentLocation),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
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
