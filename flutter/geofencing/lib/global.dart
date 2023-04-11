// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/bdd/Parcours_Points.dart';
import 'package:geofencing/bdd/Points_files.dart';
import 'package:geofencing/bdd/Zones_Point_associe.dart';
import 'package:latlong2/latlong.dart';

import 'models/points.dart';
import 'models/parcours.dart';
import 'models/parcourspoints.dart';
import 'bdd/Zone.dart';

/*
import 'package:geofencing/bdd/Parcours.dart';
import 'models/coordonnees.dart';
import 'models/etat.dart';
import 'models/parcours.dart';
import 'models/pointsfiles.dart';
import 'models/pointsvideos.dart';
import 'models/zones.dart';
import 'models/zonespoint.dart';
*/

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

  // static List<myMarker> markerList = [
  //   myMarker(LatLng(48.630963, 6.108150),
  //       const Icon(Icons.my_location, color: Colors.blue, size: 25), 0),
  //   myMarker(LatLng(48.630963, 6.107850),
  //       const Icon(Icons.my_location, color: Colors.green, size: 25), 1),
  //   myMarker(LatLng(48.631974, 6.108140),
  //       const Icon(Icons.my_location, color: Colors.green, size: 25), 2),
  //   myMarker(LatLng(48.631363, 6.107550),
  //       const Icon(Icons.my_location, color: Colors.green, size: 25), 3),
  //   myMarker(LatLng(48.629963, 6.105150),
  //       const Icon(Icons.my_location, color: Colors.blue, size: 25), 4),
  // ];
  static List<Points> pointsList = [];

  static List<Points_files> pointsFilesList = [
    Points_files(
      id: 1,
      Points_id: 1,
      directus_files_id: "324204b8-10d4-496c-9bc0-e43c8924540c",
      id_point: null,
    )
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

  static List<Zones_Point_associe> zonesPointAssocieList = [
    Zones_Point_associe(id: 1, Zones_id: 1, item: "1", collection: "Points"),
    Zones_Point_associe(id: 2, Zones_id: 2, item: "3", collection: "Points"),
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
    return toReturn;
  }

  // static List<List<int>> parcoursList = [
  //   [],
  //   [1],
  //   [0, 3],
  //   [0, 1, 2, 3],
  // ];
  static List<Parcours> parcoursList = [];

  static String getDirectusIdFromFilesId(int fileId, String pointId) {
    String toReturn = "";
    for (var file in Global.pointsFilesList) {
      if ((file.id == fileId) && (file.Points_id == pointId)) {
        toReturn = file.directus_files_id;
      }
    }
    return toReturn;
  }

  static int getParcoursIndexFromId(int parcoursId) {
    int toReturn = 0;
    int i = 0;
    for (var parcour in parcoursList) {
      if (parcour.idParcours == parcoursId) {
        toReturn = i;
      }
      i++;
    }
    return toReturn;
  }

  static int getIndexOfPointById(String id) {
    int toReturn = 0;
    int index = 0;
    for (var point in Global.pointsList) {
      if (id == point.idPoint) {
        toReturn = index;
      }
      index++;
    }
    return toReturn;
  }

  static int getPointIdByFromZone(int Point_associe) {
    int toReturn = 0;
    for (var association in Global.zonesPointAssocieList) {
      if (association.id == Point_associe) {
        toReturn = int.parse(association.item);
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
    for (var marker in Global.pointsList) {
      marker.actualGoal = false;
    }
    if (choix != -1) {
      Global.pointsList[Global.parcoursList[choix].etape[0]].actualGoal = true;
    }
  }

  static void pointChecking(id) {
    int indexPoint = getIndexOfPointById(id);
    if (Global.pointsList[indexPoint].icon.color == Colors.blue) {
      Global.pointsList[indexPoint].icon = const Icon(
          Icons.location_disabled_rounded,
          color: Colors.blue,
          size: 25);
    } else {
      Global.pointsList[indexPoint].icon = const Icon(
          Icons.location_disabled_rounded,
          color: Colors.green,
          size: 25);
    }
    if (Global.pointsList[indexPoint].actualGoal) {
      var index;
      int i = 0;
      for (var etape in Global.parcoursList[Global.choixParcours].etape) {
        if (etape == id) {
          index = i;
        }
        i++;
      }
      if (index + 1 < Global.parcoursList[Global.choixParcours].etape.length) {
        Global
            .pointsList[
                (Global.parcoursList[Global.choixParcours].etape[index + 1])]
            .actualGoal = true;
      }
      Global.pointsList[indexPoint].actualGoal = false;
    }
  }

  static void changePointToZonePoint() {
    for (var zone in Global.zonesList) {
      if (zone.Point_associe.isNotEmpty) {
        for (var point in zone.Point_associe) {
          Global.pointsList[getIndexOfPointById(getPointIdByFromZone(point))]
                  .icon =
              const Icon(Icons.my_location, color: Colors.blue, size: 25);
        }
      }
    }
  }
}
