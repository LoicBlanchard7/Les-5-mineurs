// import 'package:location/location.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geofencing/pages/ChoixParcours.dart';
// import 'package:geofencing/pages/detailPointDInteret.dart';
// import 'package:latlong2/latlong.dart';

// import '../global.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<TestPage> {
//   Future<LocationData?> _currentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     Location location = new Location();

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return null;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }
//     return await location.getLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Marker> setMarkerList() {
//       List<Marker> liste = [];
//       for (var marker in Global.markerList) {
//         if (marker.actualGoal) {
//           liste.add(Marker(
//             point: marker.localisation,
//             builder: (context) => IconButton(
//               icon: const Icon(
//                 Icons.push_pin,
//                 color: Colors.red,
//                 shadows: [Shadow(blurRadius: 2, color: Colors.blue)],
//               ),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => detailPointDInteret(marker.id)));
//               },
//             ),
//           ));
//         } else {
//           if (marker.id == null) {
//             liste.add(Marker(
//               point: marker.localisation,
//               builder: (context) => const Icon(Icons.my_location),
//             ));
//           } else {
//             liste.add(Marker(
//               point: marker.localisation,
//               builder: (context) => IconButton(
//                 icon: marker.type,
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => detailPointDInteret(marker.id)),
//                   );
//                 },
//               ),
//             ));
//           }
//         }
//       }

//       return liste;
//     }

//     var cameraIcon = const Icon(
//       Icons.cameraswitch_outlined,
//       size: 70,
//       color: Colors.black,
//     );

//     var backIcon = GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const ChoixParcours()),
//         );
//       },
//       child: const Icon(
//         Icons.arrow_back_ios_new,
//         size: 50,
//         color: Colors.black,
//       ),
//     );

//     return FutureBuilder<LocationData?>(
//       future: _currentLocation(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
//         if (snapchat.hasData) {
//           final LocationData currentLocation = snapchat.data;
//           return FlutterMap(
//             options: MapOptions(
//               center: LatLng(48.6295563, 6.107150),
//               zoom: 10,
//             ),
//             children: [
//               MapTileLayer(
//                 initialFocalLatLng: const MapLatLng(48.6295563, 6.107150),
//                 initialZoomLevel: 17,
//                 initialMarkersCount: 1,
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 markerBuilder: (BuildContext context, int index) {
//                   return MapMarker(
//                     latitude: currentLocation.latitude!,
//                     longitude: currentLocation.longitude!,
//                     size: const Size(20, 20),
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.red[800],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           );
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
