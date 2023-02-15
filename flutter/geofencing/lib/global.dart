// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/bdd/Parcours.dart';
import 'package:geofencing/bdd/Parcours_Points.dart';
import 'package:latlong2/latlong.dart';

import 'bdd/Zone.dart';

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

  // static List<CircleMarker> circles = [
  //   CircleMarker(
  //     point: LatLng(48.629963, 6.105150),
  //     radius: 25,
  //     useRadiusInMeter: true,
  //     color: const Color.fromRGBO(33, 150, 243, 0.2),
  //     borderStrokeWidth: 1.0,
  //     borderColor: Colors.blue,
  //   ),
  // ];

  // static List<Polygon> polygones = [
  //   Polygon(
  //     points: [
  //       LatLng(48.630763, 6.107150),
  //       LatLng(48.630763, 6.107750),
  //       LatLng(48.630363, 6.107550),
  //       LatLng(48.630563, 6.107150),
  //     ],
  //     color: const Color.fromRGBO(33, 150, 243, 0.2),
  //     isFilled: true,
  //     borderStrokeWidth: 1.0,
  //     borderColor: Colors.blue,
  //   ),
  // ];
  static List<Zone> zonesList = [
    Zone(1, "Z1", "Polygon", [
      [6.10871480295512, 48.63246285404148],
      [6.108598872116033, 48.63223300204797],
      [6.10909283830145, 48.632213014868825],
      [6.109097878772701, 48.632389568012485],
      [6.109259173853701, 48.63258943875064],
      [6.108921462278005, 48.63264273748041],
      [6.10871480295512, 48.63246285404148]
    ], [
      1
    ]),
    Zone(2, "zone accumulateur", "Polygon", [
      [6.107441055388648, 48.63148895480714],
      [6.107687833555275, 48.6309857851125],
      [6.107346544601569, 48.63089903121008],
      [6.107262535012978, 48.631093359744824],
      [6.10713652063049, 48.63106906871914],
      [6.107057761641102, 48.63120787442392],
      [6.107178525424331, 48.63123216538335],
      [6.107110267633459, 48.63140567189413],
      [6.107441055388648, 48.63148895480714]
    ], [
      2
    ]),
  ];

  static List<CircleMarker> getCircles() {
    List<CircleMarker> toReturn = [];
    for (var zone in Global.zonesList) {
      if (zone.type == "Circle") {
        toReturn.add(
          CircleMarker(
            point: LatLng(zone.coordinate[0], zone.coordinate[1]),
            radius: zone.radius,
            useRadiusInMeter: true,
            color: const Color.fromRGBO(33, 150, 243, 0.2),
            borderStrokeWidth: 1.0,
            borderColor: Colors.blue,
          ),
        );
      }
    }
    return toReturn;
  }

  static List<Polygon> getPolygons() {
    List<Polygon> toReturn = [];
    for (var zone in Global.zonesList) {
      if (zone.type == "Polygon") {
        List<LatLng> points = [];
        for (var point in zone.coordinates) {
          points.add(LatLng(point[1], point[0]));
        }
        toReturn.add(Polygon(
          points: points,
          color: const Color.fromRGBO(33, 150, 243, 0.2),
          isFilled: true,
          borderStrokeWidth: 1.0,
          borderColor: Colors.blue,
        ));
      }
    }
    print('toReturn - polygones');
    print(toReturn);
    return toReturn;
  }

  // static List<List<int>> parcoursList = [
  //   [],
  //   [1],
  //   [0, 3],
  //   [0, 1, 2, 3],
  // ];
  static List<Parcours> parcoursList = [
    Parcours(1, "P1", "1h30min", [13, 14]),
    Parcours(2, "P2", "3h", [15, 16, 17, 18]),
  ];

  static List<Parcours_Points> parcoursPointsList = [
    Parcours_Points(13, 5, 1),
    Parcours_Points(14, 5, 2),
    Parcours_Points(15, 6, 3),
    Parcours_Points(16, 6, 4),
    Parcours_Points(17, 6, 2),
    Parcours_Points(18, 6, 1),
  ];

  static int getParcoursIndexFromId(int parcoursId) {
    int toReturn = 0;
    int i = 0;
    for (var parcour in parcoursList) {
      if (parcour.id == parcoursId) {
        toReturn = i;
      }
      i++;
    }
    return toReturn;
  }

  static int getPointFromParcour(int idParcourPoint) {
    int toReturn = 1;
    for (var element in parcoursPointsList) {
      if (element.id == idParcourPoint) {
        toReturn = element.Points_id;
      }
    }
    return toReturn;
  }

  static int getPointInParcour(int idPoint) {
    int toReturn = 1;
    for (var element in parcoursPointsList) {
      if ((element.Points_id == idPoint) &&
          (Global.choixParcours ==
              getParcoursIndexFromId(element.Parcours_id))) {
        toReturn = element.id;
      }
    }
    return toReturn;
  }

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
    if (choix != -1) {
      Global
          .markerList[getPointFromParcour(Global.parcoursList[choix].Etapes[0])]
          .actualGoal = true;
    }
  }

  // beug lorsqu'on entre dans if .actualGoal
  static void pointChecking(id) {
    if (Global.markerList[id].type.color == Colors.blue) {
      Global.markerList[id].type = const Icon(Icons.location_disabled_rounded,
          color: Colors.blue, size: 25);
    } else {
      Global.markerList[id].type = const Icon(Icons.location_disabled_rounded,
          color: Colors.green, size: 25);
    }
    if (Global.markerList[id].actualGoal) {
      var index;
      int i = 0;
      for (var etape in Global.parcoursList[Global.choixParcours].Etapes) {
        if (getPointFromParcour(etape) == id) {
          index = i;
        }
        i++;
      }
      if (index + 1 < Global.parcoursList[Global.choixParcours].Etapes.length) {
        Global
            .markerList[getPointFromParcour(
                Global.parcoursList[Global.choixParcours].Etapes[index + 1])]
            .actualGoal = true;
      }
      Global.markerList[id].actualGoal = false;
    }
  }
}
