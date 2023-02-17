class Points {
  final int idPoint;
  final String titre;
  final String contenu;
  final double posX;
  final double posY;
  final String images;
  final String url_video;

  const Points({
    required this.idPoint,
    required this.titre,
    required this.contenu,
    required this.posX,
    required this.posY,
    required this.images,
    required this.url_video,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPoint': idPoint,
      'titre': titre,
      'contenu': contenu,
      'posX': posX,
      'posY': posY,
      'images': images,
      'url_video': url_video,
    };
  }

  @override
  String toString() {
    return 'Points{idPoint: $idPoint, titre: $titre , contenu: $contenu , posX: $posX, posY: $posY , images: $images, url_video: $url_video   }';
  }
}
