// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class Point {
  int id;
  String Titre;
  String Contenu;
  String type;
  List<double> coordinates;
  List<Video> URL_video;
  List<int> Images;
  bool actualGoal;
  Icon icon;
  Point(
    this.id,
    this.Titre,
    this.Contenu,
    this.type,
    this.coordinates,
    this.URL_video,
    this.Images, [
    this.actualGoal = false,
    this.icon = const Icon(Icons.my_location, color: Colors.green, size: 25),
  ]);
}

class Video {
  String titre;
  String Url;
  Video(this.titre, this.Url);
}
