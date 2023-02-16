// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import '../global.dart';
import 'package:geofencing/pages/ChoixParcours.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:geofencing/pages/scanQrCode.dart';
import 'package:geofencing/pages/reglages.dart';

Future<LocationData?> currentLocation() async {
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
    List<Marker> setMarkerList() {
      List<Marker> liste = [];
      for (var marker in Global.pointsList) {
        if (marker.actualGoal) {
          liste.add(Marker(
            point: LatLng(marker.coordinates[1], marker.coordinates[0]),
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
          liste.add(Marker(
              point: LatLng(marker.coordinates[1], marker.coordinates[0]),
              builder: (context) => GestureDetector(
                    child: marker.icon,
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

      return liste;
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: FutureBuilder<LocationData?>(
                // future: currentLocation(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
                  // if (snapchat.hasData) {
                  // final LocationData currentLocation = snapchat.data;
                  return FlutterMap(
                    options: MapOptions(
                      // center: LatLng(currentLocation.latitude!,
                      //     currentLocation.longitude!),
                      center: LatLng(48.6295563, 6.107150),
                      minZoom: 17,
                      maxZoom: 17,
                      zoom: 17,
                    ),
                    // mapController: mapController,
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      CircleLayer(
                        // circles: Global.circles,
                        circles: Global.getCircles(),
                      ),
                      PolygonLayer(
                        // polygons: Global.polygones,
                        polygons: Global.getPolygons(),
                      ),
                      MarkerLayer(
                        markers: setMarkerList(),
                      ),
                      // LocationMarkerLayer(
                      //     position: LocationMarkerPosition(
                      //         latitude: currentLocation.latitude!,
                      //         longitude: currentLocation.longitude!,
                      //         accuracy: currentLocation.accuracy!))
                    ],
                  );
                  // }
                  // return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 5.0,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 185, 184, 184),
          fixedColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              label: "Parcours",
              icon: GestureDetector(
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
            BottomNavigationBarItem(
              label: "QR Code",
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  color: Colors.black,
                ),
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
            ),
            BottomNavigationBarItem(
              label: "Paramètres",
              icon: GestureDetector(
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
    );
  }
}
