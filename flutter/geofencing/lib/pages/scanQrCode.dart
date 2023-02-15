// ignore_for_file: file_names, camel_case_types, unused_import
import 'package:flutter/material.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geofencing/global.dart';
import 'map.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const qrCodeScanner(title: 'Flutter Demo Home Page'),
    );
  }
}

class qrCodeScanner extends StatefulWidget {
  const qrCodeScanner({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<qrCodeScanner> createState() => _MyPageState();
}

class _MyPageState extends State<qrCodeScanner> {
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 400,
              width: 400,
              child: QRView(key: _gLobalkey, onQRViewCreated: qr),
            ),
            Center(
              child: (result != null)
                  ? ElevatedButton(
                      child: Text('Informations du point ${result!.code}'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detailPointDInteret(
                                  int.parse('${result!.code}'))),
                        );
                      })
                  /*? Text('${result!.code}')*/
                  : const Text('Scan a code'),
            )
          ],
        ),
      ),
    );
  }
}
