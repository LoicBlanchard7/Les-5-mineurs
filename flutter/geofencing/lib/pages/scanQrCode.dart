// ignore_for_file: file_names, camel_case_types, unused_import
import 'package:flutter/material.dart';
import 'package:geofencing/pages/detailPointDInteret.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geofencing/global.dart';
import 'package:geofencing/pages/map.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const qrCodeScanner(),
    );
  }
}

class qrCodeScanner extends StatefulWidget {
  const qrCodeScanner({Key? key}) : super(key: key);

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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => detailPointDInteret('${result!.code}')),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Accèder aux informations"),
          backgroundColor: const Color.fromARGB(255, 72, 68, 68),
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 202, 199, 199),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 400,
                  width: 400,
                  child: QRView(key: _gLobalkey, onQRViewCreated: qr),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Veuillez scanner un QR Code',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
