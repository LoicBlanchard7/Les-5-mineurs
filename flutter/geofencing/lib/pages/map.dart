import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geofencing/pages/reglages.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import '../global.dart';
import 'package:geofencing/pages/choixParcours.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:geofencing/pages/scanQrCode.dart';

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
            point: LatLng(marker.posY, marker.posX),
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.my_location,
                color: Colors.red,
                size: 30,
                shadows: [Shadow(blurRadius: 2, color: Colors.blue)],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            detailPointDInteret(marker.idPoint)));
              },
            ),
          ));
        } else {
          liste.add(Marker(
              point: LatLng(marker.posY, marker.posX),
              builder: (context) => GestureDetector(
                    child: marker.icon,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                detailPointDInteret(marker.idPoint)),
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
                  return FlutterMap(
                    options: MapOptions(
                      // center: LatLng(currentLocation.latitude!,
                      //     currentLocation.longitude!),
                      center: LatLng(48.6295563, 6.107150),
                      minZoom: 18,
                      maxZoom: 18,
                      zoom: 18,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      CurrentLocationLayer(
                        followOnLocationUpdate: FollowOnLocationUpdate.always,
                      ),
                      CircleLayer(
                        circles: Global.getCircles(),
                      ),
                      PolygonLayer(
                        polygons: Global.getPolygons(),
                      ),
                      MarkerLayer(
                        markers: setMarkerList(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChoixParcours()),
                    );
                  },
                  child: const Icon(
                    Icons.route_outlined,
                    color: Color.fromARGB(255, 71, 71, 71),
                  )),
              label: "Parcours"),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const qrCodeScanner()),
                  );
                },
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: Color.fromARGB(255, 71, 71, 71),
                )),
            label: 'Qr Code',
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReglagePage()),
                    );
                  },
                  child: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 71, 71, 71),
                  )),
              label: 'Paramètres'),
        ],
        currentIndex: 1,
        selectedItemColor: const Color.fromARGB(255, 71, 71, 71),
        iconSize: 35,
      ),
    );
  }
}
