// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/bdd/Parcours.dart';
import 'package:latlong2/latlong.dart';

class myMarker {
  LatLng localisation;
  Icon type;
  int id;
  bool actualGoal;
  myMarker(this.localisation, this.type, this.id, [this.actualGoal = false]);
}

class myDetail {
  String type;
  String data;
  myDetail(this.type, this.data);
}

class Global {
  static String LastUpdate = "2023-02-13T11:26:15";

  static int choixParcours = 0;

  static List<myMarker> markerList = [
    myMarker(LatLng(48.630963, 6.108150),
        const Icon(Icons.my_location, color: Colors.blue, size: 25), 0),
    myMarker(LatLng(48.630963, 6.107850),
        const Icon(Icons.my_location, color: Colors.green, size: 25), 1),
    myMarker(LatLng(48.631974, 6.108140),
        const Icon(Icons.my_location, color: Colors.green, size: 25), 2),
    myMarker(LatLng(48.631363, 6.107550),
        const Icon(Icons.my_location, color: Colors.green, size: 25), 3),
    myMarker(LatLng(48.629963, 6.105150),
        const Icon(Icons.my_location, color: Colors.blue, size: 25), 4),
  ];

  static List<CircleMarker> circles = [
    CircleMarker(
      point: LatLng(48.629963, 6.105150),
      radius: 25,
      useRadiusInMeter: true,
      color: const Color.fromRGBO(33, 150, 243, 0.2),
      borderStrokeWidth: 1.0,
      borderColor: Colors.blue,
    ),
  ];

  static List<Polygon> polygones = [
    Polygon(
      points: [
        LatLng(48.630763, 6.107150),
        LatLng(48.630763, 6.107750),
        LatLng(48.630363, 6.107550),
        LatLng(48.630563, 6.107150),
      ],
      color: const Color.fromRGBO(33, 150, 243, 0.2),
      isFilled: true,
      borderStrokeWidth: 1.0,
      borderColor: Colors.blue,
    ),
  ];

  // static List<List<int>> parcoursList = [
  //   [],
  //   [1],
  //   [0, 3],
  //   [0, 1, 2, 3],
  // ];
  static List<Parcours> parcoursList = [
    Parcours(1, "P1", "01:30", [1, 2]),
  ];

  // /!\/!\/!\/!\/!\/!\ Si on ajoute une image elle doit figurer dans "pubspec.yalm" > flutter > assets
  static List<List<myDetail>> detailsList = [
    [
      myDetail("title", "Accumulateur"),
      myDetail("txt",
          "Lorem Ipsum is simply. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      myDetail("img", "DSC_1855_DxO_R-768x512.jpg"),
    ],
    [
      myDetail("title", "Le chateau d'eau"),
      myDetail("img", "IMG_4258_DxO_R-201x300.jpg"),
      myDetail("txt",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
    ],
    [
      myDetail("title", "Entrée n°1"),
      myDetail("txt",
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
      myDetail("img", "Fete-du-fer_2017-222_DxO_R-300x300.jpg"),
      myDetail("txt",
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
    ],
    [
      myDetail("title", "Entrée n°3"),
      myDetail("txt",
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
      myDetail("txt",
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
    ],
    [
      myDetail("title", "Sortie n°2"),
      myDetail("txt",
          "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text."),
      myDetail("mp4", "https://youtu.be/nXniDOo3Y0c"),
      myDetail("txt",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      myDetail("mp4", "https://youtu.be/nXniDOo3Y0c"),
    ],
  ];

  static void selectParcours(choix) {
    Global.choixParcours = choix;
    for (var marker in Global.markerList) {
      marker.actualGoal = false;
    }
    if (Global.parcoursList[choix] != null) {
      Global.markerList[Global.parcoursList[choix].Etapes[0]].actualGoal = true;
    }
  }

  static void pointChecking(id) {
    if (Global.markerList[id].type.color == Colors.blue) {
      Global.markerList[id].type = const Icon(Icons.location_disabled_rounded,
          color: Colors.blue, size: 25);
    } else {
      Global.markerList[id].type = const Icon(Icons.location_disabled_rounded,
          color: Colors.green, size: 25);
    }
    if (Global.markerList[id].actualGoal) {
      var index = Global.parcoursList[Global.choixParcours].Etapes.indexOf(id);
      if (kDebugMode) {
        print(
            'id: $id - index : $index - choixParcours : ${Global.choixParcours}');
        print(Global.parcoursList[Global.choixParcours]);
      }
      if (index + 1 < Global.parcoursList[Global.choixParcours].Etapes.length) {
        Global
            .markerList[
                Global.parcoursList[Global.choixParcours].Etapes[index + 1]]
            .actualGoal = true;
      }
      Global.markerList[id].actualGoal = false;
    }
  }
}
