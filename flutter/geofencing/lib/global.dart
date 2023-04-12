// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/bdd/Zones_Point_associe.dart';
import 'package:latlong2/latlong.dart';

import 'models/points.dart';
import 'models/parcours.dart';
import 'models/pointsfiles.dart';
import 'models/pointsvideos.dart';
import 'models/zones.dart';
import 'models/coordonnees.dart';

/*
import 'models/etat.dart';
*/

class myMarker {
  LatLng localisation;
  Icon type;
  int id;
  bool actualGoal;
  myMarker(this.localisation, this.type, this.id, [this.actualGoal = false]);
}

class Global {
  static String LastUpdate = "2023-02-13T11:26:15";

  static int choixParcours = 0;

  static List<Points> pointsList = [];
  static List<PointsFiles> pointsFiles = [];
  static List<PointsVideos> pointVideos = [];
  static List<Zones> zonesList = [];
  static List<Coordonnees> coordonneesList = [];

  static List<Zones_Point_associe> zonesPointAssocieList = [
    Zones_Point_associe(id: 1, Zones_id: 1, item: "1", collection: "Points"),
    Zones_Point_associe(id: 2, Zones_id: 2, item: "3", collection: "Points"),
  ];

  static List<Polygon> getPolygons() {
    List<Polygon> toReturn = [];
    for (var zone in Global.zonesList) {
      List<LatLng> points = [];
      for (var point in coordonneesList
          .where((element) => element.idZone == zone.idZone)) {
        points.add(LatLng(point.posY, point.posX));
      }
      toReturn.add(Polygon(
        points: points,
        color: const Color.fromRGBO(33, 150, 243, 0.2),
        isFilled: true,
        borderStrokeWidth: 1.0,
        borderColor: Colors.blue,
      ));
    }
    return toReturn;
  }

  static List<Parcours> parcoursList = [];

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

  static int getPointIdByFromZone(String Point_associe) {
    int toReturn = 0;
    for (var association in Global.zonesPointAssocieList) {
      if (association.id == Point_associe) {
        toReturn = int.parse(association.item);
      }
    }
    return toReturn;
  }

  static void selectParcours(choix) {
    Global.choixParcours = choix;
    print(choix);
    for (var marker in Global.pointsList) {
      marker.actualGoal = false;
    }
    if (choix == -1) {
      return;
    }
    Parcours parc = Global.parcoursList
        .where((element) => element.idParcours == choix)
        .first;
    if (parc.etape.isNotEmpty) {
      if (Global.pointsList
          .where((element) => element.idPoint == parc.etape[0])
          .first
          .actualGoal = true) {
        Global.pointsList
            .where((element) => element.idPoint == parc.etape[0])
            .first
            .actualGoal = true;
      }
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
        Global.pointsList
            .where((element) =>
                element.idPoint ==
                Global.parcoursList[Global.choixParcours].etape[index + 1])
            .first
            .actualGoal = true;
      }
      Global.pointsList[indexPoint].actualGoal = false;
    }
  }

  // static void changePointToZonePoint() {
  //   for (var zone in Global.zonesList) {
  //     if (zone.pointAssocie.isNotEmpty) {
  //       for (var point in zone.pointAssocie) {
  //         Global.pointsList[getIndexOfPointById(point)].icon =
  //             const Icon(Icons.my_location, color: Colors.blue, size: 25);
  //       }
  //     }
  //   }
  // }
}
