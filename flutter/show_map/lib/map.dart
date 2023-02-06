// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];
    marker = [
      // your position
      Marker(
        point: LatLng(48.630963, 6.107150),
        builder: (ctx) => const Icon(
          Icons.my_location,
          color: Colors.black,
        ),
      ),
      // non-seen point (from zone)
      Marker(
        point: LatLng(48.630963, 6.108150),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.blue,
        ),
      ),
      // non-seen point
      Marker(
        point: LatLng(48.630963, 6.107850),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.green,
        ),
      ),
      // checked point (from zone)
      Marker(
        point: LatLng(48.631974, 6.108140),
        builder: (ctx) => const Icon(
          Icons.location_off,
          color: Colors.blue,
        ),
      ),
      // non-seen point
      Marker(
        point: LatLng(48.631974, 6.108555),
        builder: (ctx) => const Icon(
          Icons.location_off,
          color: Colors.green,
        ),
      ),
      // next goal
      Marker(
        point: LatLng(48.631363, 6.107550),
        builder: (ctx) => const Icon(
          Icons.circle,
          color: Colors.black,
        ),
      ),
      Marker(
        point: LatLng(48.631363, 6.107550),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.yellow,
        ),
      ),
    ];

    var cameraIcon = Icon(
      Icons.cameraswitch_outlined,
      size: 70,
      color: Colors.black,
    );

    var backIcon = GestureDetector(
      onTap: () {
        Navigator.pop(context);
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
                    markers: marker,
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
