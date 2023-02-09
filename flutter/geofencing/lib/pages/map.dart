// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/pages/ChoixParcours.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:geofencing/pages/scanQrCode.dart';
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
              icon: Icon(Icons.circle, color: Colors.black),
              onPressed: () {},
            ),
          ));
          liste.add(Marker(
            point: marker.localisation,
            builder: (context) => IconButton(
              icon: Icon(Icons.location_on, color: Colors.yellow),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => detailPointDInteret(marker.id)),
                );
              },
            ),
          ));
        } else {
          if (marker.type == "me") {
            liste.add(Marker(
              point: marker.localisation,
              builder: (context) => IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {},
              ),
            ));
          } else {
            Icon iconPerso;
            switch (marker.type) {
              case "non-seen point (from zone)":
                iconPerso = Icon(
                  Icons.location_on,
                  color: Colors.blue,
                );
                break;
              case "non-seen point":
                iconPerso = Icon(
                  Icons.location_on,
                  color: Colors.green,
                );
                break;
              case "checked point (from zone)":
                iconPerso = Icon(
                  Icons.location_off,
                  color: Colors.blue,
                );
                break;
              default:
                iconPerso = Icon(
                  Icons.location_off,
                  color: Colors.green,
                );
                break;
            }
            liste.add(Marker(
              point: marker.localisation,
              builder: (context) => IconButton(
                icon: iconPerso,
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

    var cameraIcon = GestureDetector(
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
        color: Colors.black,
      ),
    );

    var backIcon = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChoixParcours()),
        );
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 50,
        color: Colors.black,
      ),
    );

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
                  MarkerLayer(
                    markers: setMarkerList(),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: cameraIcon,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: backIcon,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
