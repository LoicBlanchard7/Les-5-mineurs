// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:latlong2/latlong.dart';

class myMarker {
  LatLng localisation;
  String type;
  var id;
  bool actualGoal;
  myMarker(this.localisation, this.type, this.id, this.actualGoal);
}

class myDetail {
  String type;
  String data;
  myDetail(this.type, this.data);
}

class Global {
  static int choixParcours = 3;

  static List<myMarker> markerList = [
    myMarker(
        LatLng(48.630963, 6.108150), "non-seen point (from zone)", 0, false),
    myMarker(LatLng(48.630963, 6.107850), "non-seen point", 1, false),
    myMarker(LatLng(48.631974, 6.108140), "non-seen point", 2, false),
    myMarker(LatLng(48.631363, 6.107550), "non-seen point", 3, false),
    myMarker(LatLng(48.630963, 6.107150), "me", null, false),
    // myMarker(LatLng(48.631363, 6.107550), "next goal"),
  ];

  static List<List<int>> parcoursList = [
    [],
    [1],
    [0, 3],
    [0, 1, 2, 3],
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
  ];

  static void selectParcours(choix) {
    Global.choixParcours = choix;
    for (var marker in Global.markerList) {
      marker.actualGoal = false;
    }
    if (Global.parcoursList[choix].isNotEmpty) {
      Global.markerList[Global.parcoursList[choix][0]].actualGoal = true;
    }
  }

  static void pointChecking(id) {
    switch (Global.markerList[id].type) {
      case "non-seen point (from zone)":
        Global.markerList[id].type = "checked point (from zone)";
        break;
      case "non-seen point":
        Global.markerList[id].type = "checked point";
        break;
    }
    // TODO : traiter le parcours
    if (Global.markerList[id].actualGoal) {
      var index = Global.parcoursList[Global.choixParcours].indexOf(id);
      print(
          'id: $id - index : $index - choixParcours : ${Global.choixParcours}');
      print(Global.parcoursList[Global.choixParcours]);
      if (index + 1 < Global.parcoursList[Global.choixParcours].length) {
        Global.markerList[Global.parcoursList[Global.choixParcours][index + 1]]
            .actualGoal = true;
      }
      Global.markerList[id].actualGoal = false;
    }
  }
}
