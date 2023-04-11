// ignore_for_file: library_private_types_in_public_api, file_names, camel_case_types, must_be_immutable, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:geofencing/global.dart';
import 'package:geofencing/pages/youtubePlayer.dart';
import 'map.dart';

class detailPointDInteret extends StatefulWidget {
  String id;

  detailPointDInteret(this.id, {super.key});

  @override
  _MyAppState createState() => _MyAppState(id);
}

class _MyAppState extends State<detailPointDInteret> {
  String id;

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
            Global.pointsList
                .where((element) => element.idPoint == id)
                .first
                .titre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(50.0),
          ),
        ),
      ),
    );
  }
}
