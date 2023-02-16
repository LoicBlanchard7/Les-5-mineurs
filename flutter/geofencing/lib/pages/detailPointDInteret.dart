// ignore_for_file: library_private_types_in_public_api, file_names, camel_case_types, must_be_immutable, no_logic_in_create_state
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geofencing/global.dart';
import 'package:geofencing/pages/youtubePlayer.dart';
import 'map.dart';

class detailPointDInteret extends StatefulWidget {
  int id;

  detailPointDInteret(this.id, {super.key});

  @override
  _MyAppState createState() => _MyAppState(id);
}

class _MyAppState extends State<detailPointDInteret> {
  int id;

  _MyAppState(this.id);

  @override
  Widget build(BuildContext context) {
    Global.pointChecking(id);
    List<YoutubePlayerScaffold> playersList = [];
    backPress() {
      for (var element in playersList) {
        element.stopVideo();
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapPage()),
      );
    }

    return WillPopScope(
      onWillPop: () {
        backPress();
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                size: 50, color: Colors.white),
            onPressed: () => {backPress()},
          ),
          toolbarHeight: 120,
          centerTitle: true,
          title: Text(
            Global.pointsList[Global.getIndexOfPointById(id)].Titre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(50.0),
            child: Affichage(id, playersList),
          ),
        ),
      ),
    );
  }
}

class Affichage extends StatelessWidget {
  int id;
  List<YoutubePlayerScaffold> playersList;

  Affichage(this.id, this.playersList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: contenuAffichage(context, id, playersList),
    );
  }
}

List<TableRow> contenuAffichage(
    BuildContext context, int id, List<YoutubePlayerScaffold> playersList) {
  List<TableRow> contenu = [];
  // images
  for (var image in Global.pointsList[Global.getIndexOfPointById(id)].Images) {
    contenu.add(
      TableRow(
        children: [
          Image.network(
            'http://docketu.iutnc.univ-lorraine.fr:51080/assets/${Global.getDirectusIdFromFilesId(image, id)}',
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
  // contenu
  contenu.add(
    TableRow(
      children: [
        Text(
          Global.pointsList[Global.getIndexOfPointById(id)].Contenu,
          textAlign: TextAlign.justify,
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
      ],
    ),
  );
  // videos
  for (var video
      in Global.pointsList[Global.getIndexOfPointById(id)].URL_video) {
    YoutubePlayerScaffold player = YoutubePlayerScaffold(video.Url);
    player.initState();
    contenu.add(
      TableRow(
        children: [
          player.build(context),
        ],
      ),
    );
    playersList.add(player);
  }
  return contenu;
}
