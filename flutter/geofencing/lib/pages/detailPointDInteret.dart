// ignore_for_file: library_private_types_in_public_api, file_names, camel_case_types, must_be_immutable, no_logic_in_create_state
import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
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
    var backIcon = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapPage()),
        );
      },
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 50,
        color: Colors.black,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: backIcon,
          ),
          Container(
            margin: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 50.0, bottom: 50.0),
                    child: Text(
                      Global.detailsList[id][0].data,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Affichage(id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Affichage extends StatelessWidget {
  int id;

  Affichage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      // border: TableBorder.all(),
      children: contenuAffichage(context, id),
    );
  }
}

List<TableRow> contenuAffichage(BuildContext context, int id) {
  List<TableRow> contenu = [];
  for (var element in Global.detailsList[id]) {
    switch (element.type) {
      case "txt":
        contenu.add(
          TableRow(
            children: [
              Text(
                element.data,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ],
          ),
        );
        break;
      case "img":
        contenu.add(
          TableRow(
            children: [
              Image.asset(
                'assets/${element.data}',
                fit: BoxFit.contain,
              )
            ],
          ),
        );
        break;
      case "mp4":
        YoutubePlayerScaffold player = YoutubePlayerScaffold(element.data);
        player.initState();
        contenu.add(
          TableRow(
            children: [
              player.build(context),
            ],
          ),
        );
        break;
    }
  }
  return contenu;
}
